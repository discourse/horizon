import Component from "@glimmer/component";
import { fn } from "@ember/helper";
import { action } from "@ember/object";
import { service } from "@ember/service";
import DButton from "discourse/components/d-button";

export default class SitePallette extends Component {
  @service customColor;

  @action
  handleInput(colorScheme) {
    this.customColor.setColor(colorScheme.name);
  }

  <template>
    <div class="color-pallette-menu__item">
      <DButton
        class="btn-flat color-pallette-menu__item-choice"
        style="--icon-color: {{@colorScheme.color}}"
        @icon="circle"
        @translatedLabel={{@colorScheme.name}}
        @action={{fn this.handleInput @colorScheme}}
      />
    </div>
  </template>
}
