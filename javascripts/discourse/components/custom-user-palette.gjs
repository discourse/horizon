import Component from "@glimmer/component";
import didInsert from "@ember/render-modifiers/modifiers/did-insert";
import { service } from "@ember/service";
import { TrackedArray } from "@ember-compat/tracked-built-ins";
import ConditionalLoadingSection from "discourse/components/conditional-loading-section";
import icon from "discourse/helpers/d-icon";
import { listColorSchemes } from "discourse/lib/color-scheme-picker";
import ColorScheme from "admin/models/color-scheme";
import DMenu from "float-kit/components/d-menu";
import SitePaletteMenuItem from "./site-palette-menu-item";

export default class CustomUserPalette extends Component {
  @service site;
  colorPalettes = new TrackedArray([]);

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

  buildColorPaletteObject = async () => {
    const colorSchemes = listColorSchemes(this.site);
    let colors = [];

    for (let colorScheme of colorSchemes) {
      let color = await ColorScheme.find(colorScheme.id);
      let accent = `#${color.colors[2].originals.hex}`;

      colors.push({
        id: colorScheme.id,
        name: colorScheme.name,
        accent,
      });
    }

    this.colorPalettes.push(...colors);
  };

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
        <div
          class="color-palette-menu"
          {{didInsert this.buildColorPaletteObject}}
        >
          <div class="color-palette-menu__content">
            {{#each this.colorPalettes as |colorPalette|}}
              <SitePaletteMenuItem @colorPalette={{colorPalette}} />
            {{/each}}
          </div>
        </div>
      </:content>
    </DMenu>
  </template>
}
