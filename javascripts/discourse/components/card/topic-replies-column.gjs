import icon from "discourse/helpers/d-icon";

const TopicRepliesColumn = <template>
  {{#if @topic.posts_count}}
    <span class="topic-replies">{{icon "reply"}}{{@topic.posts_count}}</span>
  {{/if}}
</template>;

export default TopicRepliesColumn;
