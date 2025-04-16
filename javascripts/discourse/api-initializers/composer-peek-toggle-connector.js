import { apiInitializer } from "discourse/lib/api";
import peekModeToggle from "../components/composer-peek-mode-toggle";

export default apiInitializer("1.8.0", (api) => {
  api.renderInOutlet("before-composer-toggles", peekModeToggle);
});
