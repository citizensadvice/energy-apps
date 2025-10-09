# frozen_string_literal: true

require "rails_helper"

RSpec.describe CsrTable::OtherInfoComponent, type: :component do
  subject { page }

  let(:supplier) { build(:supplier, :ranked) }

  before do
    render_inline described_class.new(supplier)
  end

  it { is_expected.to have_text "Opening Hours" }
  it { is_expected.to have_text "opening hours content" }

  it { is_expected.to have_text "Customer service contact details for An Energy Supplier Inc" }
  it { is_expected.to have_text "some contact details" }

  it { is_expected.to have_link "hello@example.com", href: "mailto:hello@example.com" }
end
