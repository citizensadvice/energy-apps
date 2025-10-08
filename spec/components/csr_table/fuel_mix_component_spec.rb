# frozen_string_literal: true

require "rails_helper"

RSpec.describe CsrTable::FuelMixComponent, type: :component do
  subject { page }

  let(:supplier) { build(:supplier, :ranked) }

  before do
    render_inline described_class.new(supplier)
  end

  it { is_expected.to have_text "Fuel Mix" }
  it { is_expected.to have_text "fuel mix content" }
end
