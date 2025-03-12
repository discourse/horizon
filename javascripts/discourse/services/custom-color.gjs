import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import Service, { service } from "@ember/service";

const CUSTOM_COLOR_KEY = "d-custom-color-preference";

export default class CustomColor extends Service {
  @service keyValueStore;
  @tracked color = this.keyValueStore.getItem(CUSTOM_COLOR_KEY) || "horizon";

  @action
  setColor(color) {
    this.color = color;
    this.keyValueStore.setItem(CUSTOM_COLOR_KEY, color);
  }
}
