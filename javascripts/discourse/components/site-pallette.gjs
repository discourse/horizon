import Component from "@glimmer/component";
import { fn } from "@ember/helper";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { htmlSafe } from "@ember/template";
import DButton from "discourse/components/d-button";

export default class SitePallette extends Component {
  @service customColor;

  get siteStyle() {
    return `--icon-color: ${this.args.colorScheme.color}`;
  }

  @action
  handleInput(colorScheme) {
    this.customColor.setColor(colorScheme.name);
  }

  <template>
    <div class="color-pallette-menu__item">
      <DButton
        class="btn-flat color-pallette-menu__item-choice"
        style={{htmlSafe this.siteStyle}}
        @icon="circle"
        @translatedLabel={{@colorScheme.name}}
        @action={{fn this.handleInput @colorScheme}}
      />
    </div>
  </template>
}
