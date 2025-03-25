# frozen_string_literal: true

describe "Horizon theme | High level", type: :system do
  let!(:theme) { upload_theme }
  fab!(:current_user) { Fabricate(:user) }
  fab!(:tag_1) { Fabricate(:tag, name: "wow-cool") }
  fab!(:tag_2) { Fabricate(:tag, name: "another-tag") }
  fab!(:category)
  fab!(:topic_1) { Fabricate(:topic_with_op, category: category, tags: [tag_1, tag_2]) }
  let(:topic_list) { PageObjects::Components::TopicList.new }
  let(:topic_page) { PageObjects::Pages::Topic.new }
  let(:sidebar) { PageObjects::Components::NavigationMenu::Sidebar.new }

  def run_all_high_level_tests
    expect(page).to have_css(".experimental-screen")

    expect(sidebar).to have_categories_section
    expect(sidebar).to have_section_link(category.name)

    expect(topic_list).to have_topic(topic_1)

    # Ensure the topic list columns are in the correct order via 'topic-list-columns' valueTransformer
    #
    # NOTE(martin): Maybe there is a better way to do this in a qunit test instead.
    topic_item = find(topic_list.topic_list_item_class(topic_1))
    expect(topic_item.all("td").map { |el| el["class"] }).to eq(
      [
        "main-link clearfix topic-list-data",
        "activity num topic-list-data age",
        "topic-author-data",
        "topic-category-status-data",
        "topic-author-avatar-data",
        "topic-likes-replies-data",
      ],
    )

    # Can see a topic in the list and navigate to it successfully
    topic_list.visit_topic(topic_1)
    expect(topic_page).to have_topic_title(topic_1.title)

    # Can change site colors from the sidebar palette, which are remembered across page reloads
    palette_menu =
      PageObjects::Components::DMenu.new(find(".sidebar-footer-actions .user-color-palette"))
    palette_menu.expand
    find(".color-palette-menu__content .color-palette-menu__item[data-color='Marigold']").click
    page.refresh
    expect(
      page.evaluate_script(
        "getComputedStyle(document.documentElement).getPropertyValue('--tertiary')",
      ),
    ).to eq("#d3881f")
  end

  it "works for anon" do
    visit "/"
    run_all_high_level_tests
  end

  context "for signed in users" do
    before { sign_in(current_user) }

    it "works" do
      visit "/"
      run_all_high_level_tests
    end
  end
end
