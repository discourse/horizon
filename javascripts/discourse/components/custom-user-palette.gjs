import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import AsyncContent from "discourse/components/async-content";
import icon from "discourse/helpers/d-icon";
import { listColorSchemes } from "discourse/lib/color-scheme-picker";
import { i18n } from "discourse-i18n";
import DMenu from "float-kit/components/d-menu";
import SitePaletteMenuItem from "./site-palette-menu-item";

const HORIZON_PALETTES = [
  "Horizon",
  "Marigold",
  "Violet",
  "Lily",
  "Clover",
  "Royal",
];

export default class CustomUserPalette extends Component {
  @service site;

  @action
  async buildColorPaletteObject() {
    // NOTE: The site attr is called scheme, but we actually refer to these as palettes now.
    const userColorPalettes = listColorSchemes(this.site);

    const availablePalettes = userColorPalettes
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

  <template>
    <DMenu
      @identifier="user-color-palette"
      @placementStrategy="fixed"
      class="btn-flat user-color-palette sidebar-footer-actions-button"
      @inline={{true}}
    >
      <:trigger>
        {{icon "paintbrush"}}
      </:trigger>
      <:content>
        <AsyncContent @asyncData={{this.buildColorPaletteObject}}>
          <:loading>
            {{i18n "loading"}}
          </:loading>
          <:content as |colorPalettes|>
            <div class="color-palette-menu">
              <div class="color-palette-menu__content">
                {{#each colorPalettes as |colorPalette|}}
                  <SitePaletteMenuItem @colorPalette={{colorPalette}} />
                {{/each}}
              </div>
            </div>
          </:content>
        </AsyncContent>
      </:content>
    </DMenu>
  </template>
}
