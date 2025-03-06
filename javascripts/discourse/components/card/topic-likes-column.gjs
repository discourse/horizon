import Component from "@glimmer/component";
import icon from "discourse/helpers/d-icon";

export default class TopicLikesColumn extends Component {
  constructor() {
    super(...arguments);
  }

  <template>
    {{#if @topic.like_count}}
      <span class="topic-likes">{{icon "heart"}}{{@topic.like_count}}</span>
    {{/if}}
  </template>
}
