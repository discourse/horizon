import Component from "@glimmer/component";
import avatar from "discourse/helpers/avatar";
import icon from "discourse/helpers/d-icon";
import formatDate from "discourse/helpers/format-date";
import { i18n } from "discourse-i18n";

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

  get topicUser() {
    // this should handle any case where a topic was no bumped due to a reply/post
    if (
      moment(this.args.topic.bumped_at).isAfter(this.args.topic.last_posted_at)
    ) {
      return "";
    }

    if (this.args.topic.posts_count > 1) {
      return {
        user: this.args.topic.lastPosterUser,
        username: this.args.topic.last_poster_username,
      };
    } else if (this.args.topic.posts_count === 1) {
      return {
        user: this.args.topic.creator,
        username: this.args.topic.creator.username,
      };
    }
  }

  <template>
    <span class="topic-activity">
      <div class="topic-activity__user">
        {{#if this.topicUser}}
          {{avatar this.topicUser.user imageSize="small"}}
          <span class="topic-activity__username">
            {{this.topicUser.username}}
          </span>
        {{else}}
          {{icon "pencil"}}
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
