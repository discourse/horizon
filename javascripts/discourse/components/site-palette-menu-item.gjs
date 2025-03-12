import Component from "@glimmer/component";
import { fn } from "@ember/helper";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { htmlSafe } from "@ember/template";
import DButton from "discourse/components/d-button";
import concatClass from "discourse/helpers/concat-class";

export default class SitePaletteMenuItem extends Component {
  @service customColor;

  get siteStyle() {
    return `--icon-color: ${this.args.colorPalette.color}`;
  }

  get activeClass() {
    if (this.customColor.color === this.args.colorPalette.name) {
      return "active";
    }
  }

  @action
  handleInput(colorPalette) {
    this.customColor.setColor(colorPalette.name);
  }

  <template>
    <div class="color-palette-menu__item" data-color={{@colorPalette.name}}>
      <DButton
        class={{concatClass
          "btn-flat color-palette-menu__item-choice"
          this.activeClass
        }}
        style={{htmlSafe this.siteStyle}}
        @icon="circle"
        @translatedLabel={{@colorPalette.label}}
        @action={{fn this.handleInput @colorPalette}}
      />
    </div>
  </template>
}
