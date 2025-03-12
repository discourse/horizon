import icon from "discourse/helpers/d-icon";
import gt from "truth-helpers/helpers/gt";

const TopicRepliesColumn = <template>
  {{#if (gt @topic.posts_count 1)}}
    <span class="topic-replies">{{icon "reply"}}{{@topic.posts_count}}</span>
  {{/if}}
</template>;

export default TopicRepliesColumn;
