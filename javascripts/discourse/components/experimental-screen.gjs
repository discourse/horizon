import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import didInsert from "@ember/render-modifiers/modifiers/did-insert";
import { cancel, throttle } from "@ember/runloop";
import { htmlSafe } from "@ember/template";
import { bind } from "discourse/lib/decorators";

export default class ExperimentalScreen extends Component {
  @tracked left = 0;
  @tracked right = 0;

  willDestroy() {
    super.willDestroy(...arguments);
    cancel(this._throttledCalculateDistanceHandler);
  }

  getDistance(element) {
    const rect = element.getBoundingClientRect();
    return rect;
  }

  @bind
  calculateDistance() {
    this._throttledCalculateDistanceHandler = throttle(
      this,
      this._throttledCalculateDistance,
      50
    );
  }

  _throttledCalculateDistance() {
    const element = document.getElementById("main-outlet");

    if (element) {
      const distance = this.getDistance(element);
      this.left = distance.left;
      this.right = distance.right;
    }
  }

  get distanceStyles() {
    return htmlSafe(
      `--left-distance: ${this.left}px; --right-distance: ${this.right}px;`
    );
  }

  @action
  onInsert() {
    this.calculateDistance();
    window.addEventListener("resize", this.calculateDistance);
  }

  <template>
    <ul
      class="experimental-screen"
      {{didInsert this.onInsert}}
      style={{this.distanceStyles}}
    >
      <li class="experimental-screen__top-left"></li>
      <li class="experimental-screen__top-right"></li>
      <li class="experimental-screen__bottom-left"></li>
      <li class="experimental-screen__bottom-right"></li>
      <li class="experimental-screen__bottom-bar"></li>
    </ul>
  </template>
}
