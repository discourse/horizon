import Component from "@glimmer/component";
import avatar from "discourse/helpers/avatar";
import formatDate from "discourse/helpers/format-date";
import { i18n } from "discourse-i18n";
import gt from "truth-helpers/helpers/gt";

export default class TopicActivityColumn extends Component {
  get activityText() {
    // this should handle any case where a topic was no bumped due to a reply/post
    if (
      moment(this.args.topic.bumped_at).isAfter(this.args.topic.last_posted_at)
    ) {
      return "user_updated";
    }

    if (this.args.topic.posts_count > 1) {
      return "user_replied";
    } else if (this.args.topic.posts_count === 1) {
      return "user_posted";
    }
  }

  <template>
    <span class="topic-activity">
      <div class="topic-activity__user">
        {{#if (gt @topic.replyCount 1)}}
          {{avatar @topic.lastPosterUser imageSize="small"}}
          <span
            class="topic-activity__username"
          >@{{@topic.last_poster_username}}</span>
        {{else}}
          {{avatar @topic.creator imageSize="small"}}
          <span
            class="topic-activity__username"
          >@{{@topic.creator.username}}</span>
        {{/if}}
      </div>
      <div class="topic-activity__reason">
        {{i18n (themePrefix this.activityText)}}
      </div>
      <div class="topic-activity__time">
        {{formatDate
          @topic.bumpedAt
          leaveAgo="true"
          format="medium-with-ago-and-on"
        }}
      </div>
    </span>
  </template>
}
