import Component from "@glimmer/component";
import { apiInitializer } from "discourse/lib/api";

export default apiInitializer("1.8.0", (api) => {
  api.renderInOutlet(
    "above-main-container",
    class ExperimentalScreen extends Component {
      <template>
        <ul class="experimental-screen">
          <li class="experimental-screen__top-left"></li>
          <li class="experimental-screen__top-right"></li>
          <li class="experimental-screen__bottom-left"></li>
          <li class="experimental-screen__bottom-right"></li>
          <li class="experimental-screen__bottom-bar"></li>
        </ul>
      </template>
    }
  );
});
