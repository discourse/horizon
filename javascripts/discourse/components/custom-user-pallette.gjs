import Component from "@glimmer/component";
import { array } from "@ember/helper";
import { service } from "@ember/service";
import icon from "discourse/helpers/d-icon";
import DMenu from "float-kit/components/d-menu";
import SitePallette from "./site-pallette";


const PALLETTES = [
  {
    name: "Marigold",
    color:"#d3881f"
  },
  {
    name: "Pansy",
    color:"#9b15de"
  },
  {
    name: "Rose",
    color:"#d32f2f"
  },
  {
    name: "Clover",
    color:"#4caf50"
  },
  {
    name: "Sky",
    color:"#2196f3"
  },
  {
    name: "Horizon",
    color:"#595bca"
  }

];

export default class CustomUserPallette extends Component {
  @service site;

  <template>
    <DMenu
    @identifier="user-color-pallette"
    @triggers={{array "click"}}
    @placementStrategy="fixed"
    class="btn-flat user-color-pallette sidebar-footer-actions-button"
    @inline={{true}}
    >
      <:trigger>
        {{icon "paint-brush"}}
      </:trigger>
      <:content>
      <div class="color-pallette-menu">
        <div class="color-pallette-menu__content">
          {{#each PALLETTES as |colorScheme|}}
            <SitePallette
              @colorScheme={{colorScheme}}
            />
          {{/each}}
        </div>
      </div>
      </:content>
    </DMenu>
  </template>
}
