import Component from "@glimmer/component";
import { concat } from "@ember/helper";
import { service } from "@ember/service";
import htmlClass from "discourse/helpers/html-class";

export default class CustomColorHtmlClass extends Component {
  @service customColor;

  <template>
    {{htmlClass (concat "custom-color-" this.customColor.color)}}
  </template>
}
