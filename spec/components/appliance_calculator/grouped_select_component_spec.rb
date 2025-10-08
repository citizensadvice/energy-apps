# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplianceCalculator::GroupedSelectComponent, type: :component do
  subject { page }

  let(:options) do
    [
      [
        "Group A",
        [
          ["Item 1", "1"],
          ["Item 2", "2"],
          ["Item 3", "3"]
        ]
      ],
      [
        "Group B",
        [
          ["Item 4", "4"],
          ["Item 5", "5"]
        ]
      ]
    ]
  end

  before do
    render_inline described_class.new(label: "A grouped select", name: "chosen-option", select_options: options)
  end

  it { is_expected.to have_field "A grouped select" }
  it { is_expected.to have_select "chosen-option", options: ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"] }

  it "renders the option group labels correctly" do
    expect(page.find_all("optgroup").pluck(:label)).to eq ["Group A", "Group B"]
  end
end
