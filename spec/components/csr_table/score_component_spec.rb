# frozen_string_literal: true

require "rails_helper"

RSpec.describe CsrTable::ScoreComponent, type: :component do
  subject(:score_component) { page }

  let(:score) { 3 }
  let(:show_decimal_score) { nil }

  before do
    render_inline described_class.new(score: score.presence, show_decimal_score: show_decimal_score.presence)
  end

  it { is_expected.to have_text "3 out of 5" }
  it { is_expected.to have_css ".stars" }
  it { is_expected.to have_no_css ".stars--highlight" }

  context "when the score has a decimal place that is less than .5 but not shown" do
    let(:score) { 3.4 }

    it "rounds the score down correctly" do
      expect(score_component).to have_text "3 out of 5"
    end
  end

  context "when the score has a decimal place that is more than .5 but not shown" do
    let(:score) { 3.8 }

    it "rounds the score up correctly" do
      expect(score_component).to have_text "4 out of 5"
    end
  end

  context "when the 'not scored' score is provided" do
    let(:score) { -3 }

    it { is_expected.to have_text "Not scored" }
    it { is_expected.to have_no_css ".stars" }
  end

  context "when the score is shown as a decimal" do
    let(:score) { 1.2 }
    let(:show_decimal_score) { true }

    it { is_expected.to have_text "1.2 out of 5" }
    it { is_expected.to have_css ".stars--highlight" }
  end

  context "when content is provided" do
    before do
      render_inline described_class.new(score: 2).with_content("Hello")
    end

    it { is_expected.to have_text("Hello") }
  end

  context "when no score is provided" do
    let(:score) { nil }

    it { is_expected.to have_no_text "out of" }
  end
end
