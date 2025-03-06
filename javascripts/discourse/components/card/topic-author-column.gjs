import Component from "@glimmer/component";

export default class TopicAuthorColumn extends Component {
  constructor() {
    super(...arguments);
  }

  <template>
    <span class="topic-author">@{{@topic.creator.username}}</span>
  </template>
}
