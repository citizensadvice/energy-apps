# frozen_string_literal: true

require "rails_helper"

RSpec.describe FooterComponent, type: :component do
  subject { page }

  before do
    render_inline described_class.new(
      current_path: "/immigration",
      feedback_survey_id: "1234",
      columns:
    )
  end

  let(:columns) do
    [
      {
        title: "Column 1",
        links: [
          { url: "#", title: "Link 1" },
          { url: "#", title: "Link 2" },
          { url: "#", title: "Link 3" }
        ]
      },
      {
        title: "Column 2",
        links: [
          { url: "#", title: "Link 4" },
          { url: "#", title: "Link 5" },
          { url: "#", title: "Link 6" }
        ]
      }
    ]
  end

  describe "feedback survey link" do
    it { is_expected.to have_link "Is there anything wrong", href: "https://www.research.net/r/1234?p=%2Fimmigration" }
  end

  describe "footer columns" do
    it { is_expected.to have_css "nav ul", count: 2 }
  end

  describe "Fundraising Regulator logo" do
    it { is_expected.to have_css 'img[src^="https://www.fundraisingregulator.org.uk"]' }
  end
end
