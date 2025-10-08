# frozen_string_literal: true

require "rails_helper"

RSpec.describe CsrTable::Content::RebelEnergyBustBannerComponent, type: :component do
  subject { page }

  let(:supplier) { nil }
  let(:link_url) { "/consumer/energy/energy-supply/problems-with-your-energy-supply/your-energy-supplier-has-gone-bust/" }

  before do
    render_inline described_class.new(
      supplier:,
      current_country:
    )
  end

  context "when current country is england" do
    let(:current_country) { "england" }

    context "when there is no supplier" do
      it { is_expected.to have_link href: link_url }
    end

    context "when the supplier is rebel energy" do
      let(:supplier) { build(:supplier, :rebel_energy) }

      it { is_expected.to have_link href: link_url }
    end

    context "when the supplier is not rebel energy" do
      let(:supplier) { build(:supplier) }

      it { is_expected.to have_no_link href: link_url }
    end
  end

  context "when the country is Scotland" do
    let(:current_country) { "scotland" }

    it { is_expected.to have_link href: "/scotland#{link_url}" }
  end

  context "when the country is Wales" do
    let(:current_country) { "wales" }

    it { is_expected.to have_link href: "/wales#{link_url}" }
  end
end
