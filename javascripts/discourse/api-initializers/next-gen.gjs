import { apiInitializer } from "discourse/lib/api";
import CustomColorHtmlClass from "../components/custom-color-html-class";
import ExperimentalScreen from "../components/experimental-screen";

export default apiInitializer("1.8.0", (api) => {
  api.renderInOutlet("above-main-container", ExperimentalScreen);
  api.renderInOutlet("above-main-container", CustomColorHtmlClass);
});
