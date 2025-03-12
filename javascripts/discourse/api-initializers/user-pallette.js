import { apiInitializer } from "discourse/lib/api";
import CustomUserPalette from "../components/custom-user-palette";

export default apiInitializer("1.8.0", (api) => {
  api.renderInOutlet("sidebar-footer-actions", CustomUserPalette);
});
