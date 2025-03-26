import { withPluginApi } from "discourse/lib/plugin-api";
import TopicActivityColumn from "../components/card/topic-activity-column";
import TopicCategoryColumn from "../components/card/topic-category-column";
import TopicLikesColumn from "../components/card/topic-likes-column";
import TopicRepliesColumn from "../components/card/topic-replies-column";
import TopicStatusColumn from "../components/card/topic-status-column";

const TopicActivity = <template>
  <td class="topic-activity-data">
    <TopicActivityColumn @topic={{@topic}} />
  </td>
</template>;

const TopicStatus = <template>
  <td class="topic-status-data">
    <TopicStatusColumn @topic={{@topic}} />
  </td>
</template>;

const TopicCategory = <template>
  <td class="topic-category-data">
    <TopicCategoryColumn @topic={{@topic}} />
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
          columns.add("topic-activity", {
            item: TopicActivity,
            after: "title",
          });
          columns.add("topic-status", {
            item: TopicStatus,
            after: "topic-author",
          });
          columns.add("topic-category", {
            item: TopicCategory,
            after: "topic-status",
          });
          columns.add("topic-likes-replies", {
            item: TopicLikesReplies,
            after: "topic-author-avatar",
          });
          columns.delete("posters");
          columns.delete("views");
          columns.delete("replies");
          columns.delete("activity");
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
