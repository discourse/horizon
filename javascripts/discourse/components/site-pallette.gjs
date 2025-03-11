import Component from "@glimmer/component";
import { action } from "@ember/object";
import DButton from "discourse/components/d-button";

export default class SitePallette extends Component {
    @action
    handleInput() {
        console.log(this);
    }

    <template>
        <div class="color-pallette-menu__item">
        <DButton
        class="btn-flat color-pallette-menu__item-choice"
        style="--icon-color: {{@colorScheme.color}}"
        @icon="circle"
        @translatedLabel={{@colorScheme.name}}
        @action={{this.handleInput}}
        />
        </div>
    </template>
}
