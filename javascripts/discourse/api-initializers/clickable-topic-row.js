import { apiInitializer } from "discourse/lib/api";
import { wantsNewWindow } from "discourse/lib/intercept-click";

export default apiInitializer((api) => {
  api.registerBehaviorTransformer(
    "topic-list-item-click",
    ({ context, next }) => {
      const event = context.event;
      const target = event.target;
      const topic = context.topic;

      const excludedSelectors = [
        "a:not(.title)",
        "button",
        ".bulk-select",
        ".topic-category-data",
      ];

      const isExcluded = excludedSelectors.some((selector) =>
        target.closest(selector)
      );

      if (isExcluded) {
        return next();
      }

      const mainLink = target.closest(".title, .main-link, .topic-list-item");
      if (mainLink) {
        if (wantsNewWindow(event)) {
          window.open(topic.lastUnreadUrl, "_blank");
        } else {
          event.preventDefault();
          context.navigateToTopic(topic, topic.lastUnreadUrl);
        }
        return;
      }

      next();
    }
  );
});
