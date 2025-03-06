import avatar from "discourse/helpers/avatar";

const TopicAuthorAvatarColumn = <template>
  <span class="topic-author-avatar">
    {{avatar @topic.creator imageSize="large"}}
  </span>
</template>;

export default TopicAuthorAvatarColumn;
