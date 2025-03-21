import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import AsyncContent from "discourse/components/async-content";
import icon from "discourse/helpers/d-icon";
import { i18n } from "discourse-i18n";
import ColorScheme from "admin/models/color-scheme";
import DMenu from "float-kit/components/d-menu";
import SitePaletteMenuItem from "./site-palette-menu-item";

export default class CustomUserPalette extends Component {
  @service site;

  // this function is to build a color pallet object in order to
  // add it to the colorPalettes array
  // I also want to figure out a way to add a dark mode ID to an object if there is a
  // corresponding dark mode color palette with the same name
  // the array should look like this:
  //
  // [
  //   {
  //     id: color palette id,
  //     name: color palette name,
  //     accent: hex code of "tertiary" from color palette,
  //     correspondingDarkModeId: color palette id for dark mode
  //   },
  //   ...more
  // ]

  @action
  async buildColorPaletteObject() {
    const userColorSchemes = this.site.user_color_schemes;
    const loadedColorSchemes = await ColorScheme.findAll();

    // match the user color schemes with the extra information loaded from the server
    const availablePalettes = userColorSchemes
      .map((usc) => {
        const scheme = loadedColorSchemes.find((item) => item.id === usc.id);

        return scheme
          ? {
              ...usc,
              theme_id: scheme.theme_id,
              accent: `#${scheme.colors[2].originals.hex}`,
            }
          : null;
      })
      .filter(Boolean)
      .sort();

    // match the light scheme with the corresponding dark id based in the name
    return availablePalettes.map((palette) => {
      if (palette.is_dark) {
        return palette;
      }

      const normalizedLightName = palette.name
        .toLowerCase()
        .replace(/\s+light$/, "");

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
    });
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
