import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { isEmpty } from "@ember/utils";
import icon from "discourse/helpers/d-icon";
import { reload } from "discourse/helpers/page-reloader";
import {
  listColorSchemes,
  loadColorSchemeStylesheet,
  updateColorSchemeCookie,
} from "discourse/lib/color-scheme-picker";
import DMenu from "float-kit/components/d-menu";
import UserColorPaletteMenuItem from "./user-color-palette-menu-item";

const HORIZON_PALETTES = [
  "Horizon",
  "Marigold",
  "Violet",
  "Lily",
  "Clover",
  "Royal",
];

export default class UserColorPaletteSelector extends Component {
  @service currentUser;
  @service keyValueStore;
  @service site;
  @service session;
  @service interfaceColor;
  @tracked anonColorPaletteId = this.#loadAnonColorPalette();

  constructor() {
    super(...arguments);

    // Only need to do this for anon because the current user will have their
    // color scheme cookie set and other automatic things from core loads their
    // preference.
    if (!this.currentUser && this.anonColorPaletteId) {
      loadColorSchemeStylesheet(
        this.anonColorPaletteId,
        null,
        this.interfaceColor.darkModeForced ||
          this.devicePreferredColorScheme === "dark"
      );
    }
  }

  get devicePreferredColorScheme() {
    return window.matchMedia("(prefers-color-scheme: dark)").matches
      ? "dark"
      : "light";
  }

  get userColorPalettes() {
    const availablePalettes = listColorSchemes(this.site)
      .map((userPalette) => {
        return {
          ...userPalette,
          accent: `#${
            userPalette.colors.find((color) => color.name === "tertiary").hex
          }`,
        };
      })
      .filter((userPalette) => {
        return HORIZON_PALETTES.some((palette) => {
          return userPalette.name.toLowerCase().includes(palette.toLowerCase());
        });
      })
      .sort();

    // Match the light scheme with the corresponding dark id based in the name
    return (
      availablePalettes
        .map((palette) => {
          if (palette.is_dark) {
            return palette;
          }

          const normalizedLightName = palette.name.toLowerCase();

          const correspondingDarkModeId = availablePalettes.find(
            (item) =>
              item.is_dark &&
              normalizedLightName ===
                item.name.toLowerCase().replace(/\s+dark$/, "")
          )?.id;

          return {
            ...palette,
            correspondingDarkModeId,
          };
        })
        // Only want to show palettes that have corresponding light/dark modes
        .filter((palette) => !palette.is_dark)
    );
  }

  get selectedColorPaletteId() {
    if (this.currentUser) {
      return this.session.userColorSchemeId;
    }

    return this.anonColorPaletteId;
  }

  @action
  onRegisterMenu(api) {
    this.dMenu = api;
  }

  @action
  paletteSelected(selectedPalette) {
    if (selectedPalette.id === this.selectedColorPaletteId) {
      return;
    }

    if (
      this.interfaceColor.darkModeForced ||
      this.devicePreferredColorScheme === "dark"
    ) {
      loadColorSchemeStylesheet(
        selectedPalette.correspondingDarkModeId,
        null,
        true
      );
      this.#updatePreference(selectedPalette);
    } else {
      loadColorSchemeStylesheet(selectedPalette.id);
      this.#updatePreference(selectedPalette);
    }
    if (this.currentUser) {
      // We close the menu first here because otherwise the active item
      // does not match the selected color, which is confusing.
      this.dMenu.close();
      reload();
    }
  }

  #updatePreference(selectedPalette) {
    if (this.currentUser) {
      updateColorSchemeCookie(selectedPalette.id);
      updateColorSchemeCookie(selectedPalette.correspondingDarkModeId, {
        dark: true,
      });
    } else {
      this.keyValueStore.setItem(
        "anon-horizon-color-palette-id",
        selectedPalette.id
      );
      this.anonColorPaletteId = selectedPalette.id;
    }
  }

  #loadAnonColorPalette() {
    const storedAnonPaletteId = this.keyValueStore.getItem(
      "anon-horizon-color-palette-id"
    );
    if (storedAnonPaletteId) {
      return parseInt(storedAnonPaletteId, 10);
    }
  }

  <template>
    {{#unless (isEmpty this.userColorPalettes)}}
      <DMenu
        @identifier="user-color-palette-selector"
        @placementStrategy="fixed"
        @onRegisterApi={{this.onRegisterMenu}}
        class="btn-flat user-color-palette-selector sidebar-footer-actions-button"
        data-selected-color-palette-id={{this.selectedColorPaletteId}}
        @inline={{true}}
      >
        <:trigger>
          {{icon "paintbrush"}}
        </:trigger>
        <:content>
          <div class="user-color-palette-menu">
            <div class="user-color-palette-menu__content">
              {{#each this.userColorPalettes as |colorPalette|}}
                <UserColorPaletteMenuItem
                  @selectedColorPaletteId={{this.selectedColorPaletteId}}
                  @colorPalette={{colorPalette}}
                  @paletteSelected={{this.paletteSelected}}
                />
              {{/each}}
            </div>
          </div>
        </:content>
      </DMenu>
    {{/unless}}
  </template>
}
