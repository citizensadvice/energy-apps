# frozen_string_literal: true

require "rails_helper"

RSpec.describe ImpactSurveyComponent, type: :component do
  subject { page }

  context "with impact survey id" do
    before do
      render_inline described_class.new(impact_survey_id: "1234")
    end

    it { is_expected.to have_link "Take 3 minutes to tell us if you found what you needed on our website.", href: %r{https://www.research.net/r/1234} }
    it { is_expected.to have_css "h2", text: "Help us improve our website" }
    it { is_expected.to have_text "Your feedback will help us give millions of people the information they need." }
  end

  context "without impact survey id" do
    before do
      render_inline described_class.new(impact_survey_id: "")
    end

    it "is expected to have no selector .cads-callout" do
      expect(page).to have_no_css ".cads-callout"
    end
  end
end
