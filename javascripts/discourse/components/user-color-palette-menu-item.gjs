import Component from "@glimmer/component";
import { service } from "@ember/service";
import { htmlSafe } from "@ember/template";
import DButton from "discourse/components/d-button";
import concatClass from "discourse/helpers/concat-class";

export default class UserColorPaletteMenuItem extends Component {
  @service site;
  @service session;

  get siteStyle() {
    return `--icon-color: ${this.args.colorPalette.accent}`;
  }

  get activeClass() {
    if (this.args.selectedColorPaletteId === this.args.colorPalette.id) {
      return "active";
    }
  }

  <template>
    <div
      class="user-color-palette-menu__item"
      data-color-palette={{@colorPalette.name}}
    >
      <DButton
        class={{concatClass
          "btn-flat user-color-palette-menu__item-choice"
          this.activeClass
        }}
        style={{htmlSafe this.siteStyle}}
        @icon="circle"
        @translatedLabel={{@colorPalette.name}}
        @action={{@paletteSelected @colorPalette}}
      />
    </div>
  </template>
}
