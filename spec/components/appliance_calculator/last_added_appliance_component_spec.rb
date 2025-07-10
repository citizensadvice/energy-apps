# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplianceCalculator::LastAddedApplianceComponent, type: :component do
  subject { page }

  before do
    render_inline described_class.new(message)
  end

  context "when there is a message" do
    let(:message) { "This is the message" }

    it { is_expected.to have_text "This is the message" }
    it { is_expected.to have_button aria: { label: "Close last added appliance notice" } }
  end

  context "when there is no message" do
    let(:message) { nil }

    it { is_expected.not_to have_css "body" }
  end
end
