import { apiInitializer } from "discourse/lib/api";
import ClassAdder from "../components/class-adder";
import ExperimentalScreen from "../components/experimental-screen";

export default apiInitializer("1.8.0", (api) => {
  api.renderInOutlet("above-main-container", ExperimentalScreen);
  api.renderInOutlet("above-main-container", ClassAdder);
});
