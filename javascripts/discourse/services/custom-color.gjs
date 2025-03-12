import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import Service, { service } from "@ember/service";
import { DEFAULT_PALETTE_NAME } from "../components/custom-user-palette";

const CUSTOM_COLOR_KEY = "d-custom-color-preference";

export default class CustomColor extends Service {
  @service keyValueStore;
  @tracked
  color = this.keyValueStore.getItem(CUSTOM_COLOR_KEY) || DEFAULT_PALETTE_NAME;

  @action
  setColor(color) {
    this.color = color;
    this.keyValueStore.setItem(CUSTOM_COLOR_KEY, color);
  }
}
