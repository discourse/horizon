import Component from "@glimmer/component";
import icon from "discourse/helpers/d-icon";

export default class TopicRepliesColumn extends Component {
  constructor() {
    super(...arguments);
  }

  <template>
    {{#if @topic.posts_count}}
      <span class="topic-replies">{{icon "reply"}}{{@topic.posts_count}}</span>
    {{/if}}
  </template>
}
