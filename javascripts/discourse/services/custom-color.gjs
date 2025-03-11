import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import Service from "@ember/service";

export default class customColor extends Service {
  @tracked color = localStorage.getItem("d-customColor");

  @action
  setColor(color) {
    this.color = color;
    localStorage.setItem("d-customColor", color);
  }
}
