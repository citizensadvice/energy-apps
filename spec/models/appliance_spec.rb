# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Appliance) do
  describe "#fetch_all" do
    subject(:all_appliances) { described_class.fetch_all }

    context "when test appliances are fetched" do
      around do |example|
        ClimateControl.modify(USE_TEST_SUPPLIERS: "true") do
          VCR.use_cassette("appliance/fetch_all_test", match_requests_on: [:body]) do
            example.run
          end
        end
      end

      it { is_expected.to be_present }

      it "only return appliances that have been tagged with 'test'" do
        all_appliances.each do |appliance|
          tags = appliance.data.contentful_metadata.tags.map(&:id)
          expect(tags).to include "test"
        end
      end
    end

    context "when production suppliers are fetched" do
      around do |example|
        ClimateControl.modify(USE_TEST_SUPPLIERS: "false") do
          VCR.use_cassette("appliance/fetch_all_production", match_requests_on: [:body]) do
            example.run
          end
        end
      end

      it "only does not return any suppliers that have been tagged with 'test'" do
        all_appliances.each do |appliance|
          tags = appliance.data.contentful_metadata.tags.map(&:id)
          expect(tags).not_to include "test"
        end
      end
    end
  end

  describe "a standard appliance" do
    subject { build(:appliance) }

    its(:name) { is_expected.to eq "A test appliance" }
    its(:category) { is_expected.to eq "Test group" }
    its(:wattage) { is_expected.to eq 1000 }
    its(:usage_type) { is_expected.to eq "Time" }
    its(:additional_usage) { is_expected.to be_nil }
    its(:id) { is_expected.to eq "contentful-id-1234" }

    it { is_expected.not_to be_cyclical }
  end

  describe "a cyclical appliance" do
    subject { build(:appliance, :cyclical) }

    its(:usage_type) { is_expected.to eq "Cycles" }
    it { is_expected.to be_cyclical }
  end

  describe "an appliance with variants" do
    subject(:appliance) { build(:appliance, :with_variants) }

    its(:variants?) { is_expected.to be true }
    its(:variant_question) { is_expected.to be "What type of tumble dryer?" }
    its(:variant_options) { is_expected.to be_present }

    it "creates the correct list of options" do
      options = appliance.variant_options.map { |a| [a.text, a.value] }
      expect(options).to eq [["Type 1", "1000"], ["Type 2", "500"]]
    end
  end
end
