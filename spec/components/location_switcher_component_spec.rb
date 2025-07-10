# frozen_string_literal: true

require "rails_helper"

RSpec.describe LocationSwitcherComponent, type: :component do
  subject { page }

  before do
    render_inline described_class.new(
      current_country:
    )
  end

  context "when current country is england" do
    let(:current_country) { "england" }

    it { is_expected.to have_text "This advice applies to England" }
    it { is_expected.to have_link "a", text: "See advice for Scotland" }
    it { is_expected.to have_link "a", text: "See advice for Wales" }
    it { is_expected.to have_no_link "a", text: "See advice for England" }
  end

  context "when current country is scotland" do
    let(:current_country) { "scotland" }

    it { is_expected.to have_text "This advice applies to Scotland" }
    it { is_expected.to have_link "a", text: "See advice for England" }
    it { is_expected.to have_link "a", text: "See advice for Wales" }
    it { is_expected.to have_no_link "a", text: "See advice for Scotland" }
  end

  context "when current country is wales" do
    let(:current_country) { "wales" }

    it { is_expected.to have_text "This advice applies to Wales" }
    it { is_expected.to have_link "a", text: "See advice for England" }
    it { is_expected.to have_link "a", text: "See advice for Scotland" }
    it { is_expected.to have_no_link "a", text: "See advice for Wales" }
  end
end
