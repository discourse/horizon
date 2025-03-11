import { array } from "@ember/helper";
import icon from "discourse/helpers/d-icon";
import DMenu from "float-kit/components/d-menu";
import SitePallette from "./site-pallette";

const PALLETTES = [
  {
    name: "marigold",
    color: "#d3881f",
  },
  {
    name: "violet",
    color: "#9b15de",
  },
  {
    name: "lily",
    color: "#CC336F",
  },
  {
    name: "clover",
    color: "#45a06e",
  },
  {
    name: "royal",
    color: "#4169e1",
  },
  {
    name: "horizon",
    color: "#595bca",
  },
];

<template>
  <DMenu
    @identifier="user-color-pallette"
    @triggers={{array "click"}}
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
          {{#each PALLETTES as |colorScheme|}}
            <SitePallette @colorScheme={{colorScheme}} />
          {{/each}}
        </div>
      </div>
    </:content>
  </DMenu>
</template>
