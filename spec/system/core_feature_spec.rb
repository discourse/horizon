# frozen_string_literal: true

RSpec.describe "Core features", type: :system do
  before { upload_theme }
  it_behaves_like "having working core features", skip_examples: %i[topics search]
end
