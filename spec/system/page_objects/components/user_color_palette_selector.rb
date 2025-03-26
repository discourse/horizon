# frozen_string_literal: true

module PageObjects
  module Components
    class UserColorPaletteSelector < PageObjects::Components::Base
      def open_palette_menu
        palette_menu =
          PageObjects::Components::DMenu.new(
            find(".sidebar-footer-actions .user-color-palette-selector"),
          )
        palette_menu.expand
      end

      def click_palette_menu_item(palette_name)
        find(
          ".user-color-palette-menu__content .user-color-palette-menu__item[data-color-palette='#{palette_name}']",
        ).click
      end

      def has_selected_palette?(palette)
        has_css?(".user-color-palette-selector[data-selected-color-palette-id='#{palette.id}']")
      end

      def has_computed_color?(palette, color_name)
        computed_color_hex =
          page.evaluate_script(
            "getComputedStyle(document.documentElement).getPropertyValue('--#{color_name}')",
          )
        computed_color_hex == "#" + palette.colors.find { |color| color.name == color_name }.hex
      end
    end
  end
end
