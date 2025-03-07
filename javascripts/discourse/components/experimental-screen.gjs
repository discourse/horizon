import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import didInsert from "@ember/render-modifiers/modifiers/did-insert";
import { htmlSafe } from "@ember/template";
import { bind } from "discourse/lib/decorators";

export default class ExperimentalScreen extends Component {
  @tracked left = 0;
  @tracked right = 0;
  resizeObserver;

  willDestroy() {
    super.willDestroy(...arguments);
    this.resizeObserver.disconnect();
  }

  @bind
  calculateDistance(element) {
    const distance = element.getBoundingClientRect();

    this.left = distance.left;
    this.right = distance.right;
  }

  get distanceStyles() {
    return htmlSafe(
      `--left-distance: ${this.left}px; --right-distance: ${this.right}px;`
    );
  }

  @action
  onInsert(element) {
    this.calculateDistance(element);

    this.resizeObserver = new ResizeObserver((entries) => {
      console.log("resize observer", entries);

      for (const entry of entries) {
        this.calculateDistance(entry.target);
      }
    });

    this.resizeObserver.observe(element);
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
