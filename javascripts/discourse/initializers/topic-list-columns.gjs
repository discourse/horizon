import { withPluginApi } from "discourse/lib/plugin-api";
import TopicAuthorAvatarColumn from "../components/card/topic-author-avatar-column";
import TopicAuthorColumn from "../components/card/topic-author-column";
import TopicCategoryColumn from "../components/card/topic-category-column";
import TopicLikesColumn from "../components/card/topic-likes-column";
import TopicRepliesColumn from "../components/card/topic-replies-column";
import TopicStatusColumn from "../components/card/topic-status-column";

const TopicAuthor = <template>
  <td class="topic-author-data">
    <TopicAuthorColumn @topic={{@topic}} />
  </td>
</template>;

const TopicAuthorAvatar = <template>
  <td class="topic-author-avatar-data">
    <TopicAuthorAvatarColumn @topic={{@topic}} />
  </td>
</template>;

const TopicCategoryStatus = <template>
  <td class="topic-category-status-data">
    <TopicCategoryColumn @topic={{@topic}} />
    <TopicStatusColumn @topic={{@topic}} />
  </td>
</template>;

const TopicLikesReplies = <template>
  <td class="topic-likes-replies-data">
    <TopicLikesColumn @topic={{@topic}} />
    <TopicRepliesColumn @topic={{@topic}} />
  </td>
</template>;

export default {
  name: "topic-list-customizations",

  initialize() {
    withPluginApi("1.39.0", (api) => {
      api.registerValueTransformer(
        "topic-list-columns",
        ({ value: columns }) => {
          columns.add("topic-author", {
            item: TopicAuthor,
            after: "activity",
          });
          columns.add("topic-category-status", {
            item: TopicCategoryStatus,
            after: "topic-author",
          });
          columns.add("topic-author-avatar", {
            item: TopicAuthorAvatar,
            after: "topic-category-status",
          });
          columns.add("topic-likes-replies", {
            item: TopicLikesReplies,
            after: "topic-author-avatar",
          });
          columns.delete("posters");
          columns.delete("views");
          columns.delete("replies");
          return columns;
        }
      );

      api.registerValueTransformer(
        "topic-list-item-class",
        ({ value: classes, context }) => {
          if (context.topic.pinned || context.topic.pinned_globally) {
            classes.push("--pinned");
          }
          return classes;
        }
      );

      api.registerValueTransformer("topic-list-item-mobile-layout", () => {
        return false;
      });
    });
  },
};
