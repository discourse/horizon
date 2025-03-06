import Component from "@glimmer/component";
import { on } from "@ember/modifier";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { and } from "truth-helpers";
import icon from "discourse/helpers/d-icon";
import i18n from "discourse-i18n";

export default class TopicStatusColumn extends Component {
  @service currentUser;
  @service siteSettings;

  get canAct() {
    return this.currentUser && !this.args.disableActions;
  }

  get statusClass() {
    let classes = ["topic-status-card"];
    if (this.args.topic.bookmarked) {
      classes.push("--bookmark");
    } else if (this.args.topic.closed && this.args.topic.archived) {
      classes.push("--locked --archived");
    } else if (this.args.topic.closed) {
      classes.push("--locked");
    } else if (this.args.topic.archived) {
      classes.push("--archived");
    } else if (this.args.topic.is_warning) {
      classes.push("--warning");
    } else if (
      this.args.showPrivateMessageIcon &&
      this.args.topic.isPrivateMessage
    ) {
      classes.push("--private-message");
    } else if (this.args.topic.pinned) {
      classes.push("--pinned");
    } else if (this.args.topic.unpinned) {
      classes.push("--unpinned");
    }
    return classes.join(" ");
  }

  get heatMap() {
    return this.args.topic.views > this.siteSettings.topic_views_heat_medium;
  }

  @action
  togglePinned(event) {
    event.preventDefault();
    this.args.topic.togglePinnedForUser();
  }

  <template>
    {{#if @topic.bookmarked}}
      <span class={{this.statusClass}}>{{icon "bookmark"}}{{i18n
          (themePrefix "topic_bookmarked")
        }}</span>
    {{/if}}
    {{#if (and @topic.closed @topic.archived)~}}
      <span class={{this.statusClass}}>{{i18n
          (themePrefix "topic_closed_and_archived")
        }}</span>
    {{else if @topic.closed}}
      <span class={{this.statusClass}}>{{i18n
          (themePrefix "topic_closed")
        }}</span>
    {{else if @topic.archived}}
      <span class={{this.statusClass}}>{{i18n
          (themePrefix "topic_archived")
        }}</span>
    {{/if}}
    {{#if @topic.is_warning}}
      <span class={{this.statusClass}}>{{i18n
          (themePrefix "topic_warning")
        }}</span>
    {{else if (and @showPrivateMessageIcon @topic.isPrivateMessage)}}
      <span class={{this.statusClass}}>{{i18n
          (themePrefix "topic_personal_message")
        }}</span>
    {{/if}}
    {{#if @topic.pinned}}
      {{#if this.canAct}}
        <button
          type="button"
          {{on "click" this.togglePinned}}
          class={{this.statusClass}}
        >{{icon "thumbtack"}}{{i18n (themePrefix "topic_pinned")}}</button>
      {{else}}
        <span class={{this.statusClass}}>{{icon "thumbtack"}}{{i18n
            (themePrefix "topic_pinned")
          }}</span>
      {{/if}}
    {{else if @topic.unpinned}}
      {{#if this.canAct}}
        <button
          type="button"
          {{on "click" this.togglePinned}}
          class={{this.statusClass}}
        >{{icon "thumbtack" class="unpinned"}}{{i18n
            (themePrefix "topic_unpinned")
          }}</button>
      {{else}}
        <span class={{this.statusClass}}>{{icon
            "thumbtack"
            class="unpinned"
          }}{{i18n (themePrefix "topic_unpinned")}}</span>
      {{/if}}
    {{/if}}

    {{#if this.heatMap}}
      <span class="topic-status-card --hot">{{icon "fire"}}{{i18n
          (themePrefix "topic_hot")
        }}</span>
    {{/if}}
  </template>
}
