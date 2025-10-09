# frozen_string_literal: true

require "rails_helper"

RSpec.describe CsrTable::StarsComponent, type: :component do
  subject(:score_component) { page }

  let(:score) { 3 }
  let(:highlight_stars) { nil }

  before do
    render_inline described_class.new(highlight_stars: highlight_stars.presence, score: score.presence)
  end

  it { is_expected.to have_css ".star--full", count: 3 }
  it { is_expected.to have_css ".star--empty", count: 2 }
  it { is_expected.to have_no_css ".star--half" }

  context "when the stars are highlighted" do
    let(:highlight_stars) { true }

    context "when the score is decimal" do
      let(:score) { 2.8 }

      it { is_expected.to have_css ".stars--highlight" }
      it { is_expected.to have_css ".star--full", count: 2 }
      it { is_expected.to have_css ".star--empty", count: 2 }
      it { is_expected.to have_css ".star--half", count: 1 }
    end

    context "when the score is not decimal" do
      let(:score) { 2 }

      it { is_expected.to have_css ".stars--highlight" }
      it { is_expected.to have_css ".star--full", count: 2 }
      it { is_expected.to have_css ".star--empty", count: 3 }
      it { is_expected.to have_no_css ".star--half" }
    end
  end
end
