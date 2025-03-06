import { apiInitializer } from "discourse/lib/api";
import ExperimentalScreen from "../components/experimental-screen";

export default apiInitializer("1.8.0", (api) => {
  api.renderInOutlet("above-main-container", ExperimentalScreen);
});
