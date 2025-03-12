import { apiInitializer } from "discourse/lib/api";
import CustomUserPallette from "../components/custom-user-pallette";

export default apiInitializer("1.8.0", (api) => {
  api.renderInOutlet("sidebar-footer-actions", CustomUserPallette);
});
