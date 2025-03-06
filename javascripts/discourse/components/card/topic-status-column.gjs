import Component from "@glimmer/component";
import { on } from "@ember/modifier";
import { action } from "@ember/object";
import { service } from "@ember/service";
import { and } from "truth-helpers";
import icon from "discourse/helpers/d-icon";

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
  togglePinned(e) {
    e.preventDefault();
    this.args.topic.togglePinnedForUser();
  }

  <template>
    {{#if @topic.bookmarked}}
      <span class={{this.statusClass}}>{{icon "bookmark"}}Bookmarked</span>
    {{/if}}
    {{#if (and @topic.closed @topic.archived)~}}
      <span class={{this.statusClass}}>Locked and Archived</span>
    {{else if @topic.closed}}
      <span class={{this.statusClass}}>Locked</span>
    {{else if @topic.archived}}
      <span class={{this.statusClass}}>Archived</span>
    {{/if}}
    {{#if @topic.is_warning}}
      <span class={{this.statusClass}}>Warning</span>
    {{else if (and @showPrivateMessageIcon @topic.isPrivateMessage)}}
      <span class={{this.statusClass}}>Private Message</span>
    {{/if}}
    {{#if @topic.pinned}}
      {{#if this.canAct}}
        <button
          type="button"
          {{on "click" this.togglePinned}}
          class={{this.statusClass}}
        >{{icon "thumbtack"}}Pinned</button>
      {{else}}
        <span class={{this.statusClass}}>{{icon "thumbtack"}}Pinned</span>
      {{/if}}
    {{else if @topic.unpinned}}
      {{#if this.canAct}}
        <button
          type="button"
          {{on "click" this.togglePinned}}
          class={{this.statusClass}}
        >{{icon "thumbtack" class="unpinned"}}Unpinned</button>
      {{else}}
        <span class={{this.statusClass}}>{{icon
            "thumbtack"
            class="unpinned"
          }}Unpinned</span>
      {{/if}}
    {{/if}}

    {{#if this.heatMap}}
      <span class="topic-status-card --hot">{{icon "fa-fire"}}Hot</span>
    {{/if}}
  </template>
}
