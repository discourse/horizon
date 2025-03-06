import Component from "@glimmer/component";
import { categoryLinkHTML } from "discourse/helpers/category-link";

export default class TopicAuthorColumn extends Component {
  constructor() {
    super(...arguments);
  }

  <template>
    {{categoryLinkHTML @topic.category}}
  </template>
}
