import icon from "discourse/helpers/d-icon";
import DMenu from "float-kit/components/d-menu";
import SitePallette from "./site-pallette";

const PALLETTES = [
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

<template>
  <DMenu
    @identifier="user-color-pallette"
    @placementStrategy="fixed"
    class="btn-flat user-color-pallette sidebar-footer-actions-button"
    @inline={{true}}
  >
    <:trigger>
      {{icon "paintbrush"}}
    </:trigger>
    <:content>
      <div class="color-pallette-menu">
        <div class="color-pallette-menu__content">
          {{#each PALLETTES as |colorPalette|}}
            <SitePallette @colorPalette={{colorPalette}} />
          {{/each}}
        </div>
      </div>
    </:content>
  </DMenu>
</template>
