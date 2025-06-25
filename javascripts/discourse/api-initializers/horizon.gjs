import { addGlobalNotice } from "discourse/components/global-notice";
import { apiInitializer } from "discourse/lib/api";
import getURL from "discourse/lib/get-url";
import { currentThemeId } from "discourse/lib/theme-selector";
import ExperimentalScreen from "../components/experimental-screen";
import UserColorPaletteSelector from "../components/user-color-palette-selector";

export default apiInitializer("1.8.0", (api) => {
  if (api.getCurrentUser()?.admin) {
    const themeId = currentThemeId();
    const themeURL = getURL(`/admin/customize/themes/${themeId}`);
    const horizonThemeUrl = getURL(`/admin/customize/themes/-2`);
    addGlobalNotice(
      `<b>Admin notice:</b> you are using the <em>Horizon (beta)</em> theme. This theme is now installed automatically in Discourse core. You should <a href="${themeURL}">uninstall this theme</a>, and reconfigure the <a href="${horizonThemeUrl}">preinstalled Horizon theme</a>.`,
      "loading-slider-theme",
      {
        dismissable: true,
        level: "warn",
        dismissDuration: moment.duration("1", "hour"),
      }
    );
  }

  api.renderInOutlet("above-main-container", ExperimentalScreen);
  api.renderInOutlet("sidebar-footer-actions", UserColorPaletteSelector);

  api.registerValueTransformer("site-setting-enable-welcome-banner", () => {
    return settings.enable_welcome_banner;
  });

  api.registerValueTransformer("site-setting-search-experience", () => {
    return settings.search_experience;
  });
});
