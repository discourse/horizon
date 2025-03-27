import icon from "discourse/helpers/d-icon";
import gt from "truth-helpers/helpers/gt";

const TopicRepliesColumn = <template>
  {{log @topic}}
  {{#if (gt @topic.replyCount 1)}}
    <span class="topic-replies">{{icon "reply"}}{{@topic.replyCount}}</span>
  {{/if}}
</template>;

export default TopicRepliesColumn;
