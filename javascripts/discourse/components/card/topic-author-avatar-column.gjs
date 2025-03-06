import Component from "@glimmer/component";
import avatar from "discourse/helpers/avatar";

export default class TopicAuthorColumn extends Component {
  constructor() {
    super(...arguments);
  }

  <template>
    <span class="topic-author-avatar">
      {{avatar @topic.creator imageSize="large"}}
    </span>
  </template>
}
