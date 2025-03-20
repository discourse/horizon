import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { htmlSafe } from "@ember/template";
import DButton from "discourse/components/d-button";
import concatClass from "discourse/helpers/concat-class";
import {
  loadColorSchemeStylesheet,
  updateColorSchemeCookie,
} from "discourse/lib/color-scheme-picker";

export default class SitePaletteMenuItem extends Component {
  @service site;

  get siteStyle() {
    return `--icon-color: ${this.args.colorPalette.accent}`;
  }

  @action
  handleInput() {
    loadColorSchemeStylesheet(this.args.colorPalette.id);
    // also somehow set the dark mode color scheme
    // using correspondingDarkModeId
    updateColorSchemeCookie(this.args.colorPalette.id);
  }

  <template>
    <div class="color-palette-menu__item" data-color="color-palette-name">
      <DButton
        class={{concatClass "btn-flat color-palette-menu__item-choice"}}
        style={{htmlSafe this.siteStyle}}
        @icon="circle"
        @translatedLabel={{@colorPalette.name}}
        @action={{this.handleInput}}
      />
    </div>
  </template>
}
