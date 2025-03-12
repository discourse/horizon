import icon from "discourse/helpers/d-icon";
import DMenu from "float-kit/components/d-menu";
import SitePaletteMenuItem from "./site-palette-menu-item";

const PALETTES = [
  {
    label: "Marigold",
    name: "marigold",
    color: "#d3881f",
  },
  {
    label: "Violet",
    name: "violet",
    color: "#9b15de",
  },
  {
    label: "Lily",
    name: "lily",
    color: "#CC336F",
  },
  {
    label: "Clover",
    name: "clover",
    color: "#45a06e",
  },
  {
    label: "Royal",
    name: "royal",
    color: "#4169e1",
  },
  {
    label: "Horizon",
    name: "horizon",
    color: "#595bca",
  },
];

export const DEFAULT_PALETTE_NAME = "horizon";

<template>
  <DMenu
    @identifier="user-color-palette"
    @placementStrategy="fixed"
    class="btn-flat user-color-palette sidebar-footer-actions-button"
    @inline={{true}}
  >
    <:trigger>
      {{icon "paintbrush"}}
    </:trigger>
    <:content>
      <div class="color-palette-menu">
        <div class="color-palette-menu__content">
          {{#each PALETTES as |colorPalette|}}
            <SitePaletteMenuItem @colorPalette={{colorPalette}} />
          {{/each}}
        </div>
      </div>
    </:content>
  </DMenu>
</template>
