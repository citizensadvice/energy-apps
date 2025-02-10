# frozen_string_literal: true

require "rails_helper"

RSpec.describe BreadcrumbsComponent, type: :component do
  subject { page }

  let(:current_page_title) { "Appliance calculator page" }

  before do
    render_inline described_class.new(current_page_title: current_page_title)
  end

  it { is_expected.to have_text "Appliance calculator page" }
end
