import { apiInitializer } from "discourse/lib/api";
import CustomUserPalette from "../components/custom-user-palette";
import CustomColorHtmlClass from "../components/custom-color-html-class";
import ExperimentalScreen from "../components/experimental-screen";

export default apiInitializer("1.8.0", (api) => {
  api.renderInOutlet("above-main-container", ExperimentalScreen);
  api.renderInOutlet("above-main-container", CustomColorHtmlClass);
  api.renderInOutlet("sidebar-footer-actions", CustomUserPalette);

  api.registerValueTransformer("enable-welcome-banner", () => {
    return settings.enable_welcome_banner;
  });

  api.registerValueTransformer("search-experience", () => {
    return settings.search_experience;
  });
});
