# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Supplier) do
  describe "#fetch_all" do
    subject(:all_suppliers) { described_class.fetch_all }

    context "when test suppliers are fetched" do
      around do |example|
        ClimateControl.modify(USE_TEST_SUPPLIERS: "true") do
          VCR.use_cassette("supplier/fetch_all_test", match_requests_on: [:body]) do
            example.run
          end
        end
      end

      it { is_expected.to be_present }

      it "returns ranked suppliers in ascending rank order" do
        expect(all_suppliers.filter_map(&:rank)).to eql [901, 902, 903, 904, 905, 906, 907]
      end

      it "only return suppliers that have been tagged with 'test'" do
        all_suppliers.each do |supplier|
          tags = supplier.data.contentful_metadata.tags.map(&:id)
          expect(tags).to include "test"
        end
      end
    end

    context "when production suppliers are fetched" do
      around do |example|
        ClimateControl.modify(USE_TEST_SUPPLIERS: "false") do
          VCR.use_cassette("supplier/fetch_all_production", match_requests_on: [:body]) do
            example.run
          end
        end
      end

      it "only does not return any suppliers that have been tagged with 'test'" do
        all_suppliers.each do |supplier|
          tags = supplier.data.contentful_metadata.tags.map(&:id)
          expect(tags).not_to include "test"
        end
      end
    end
  end

  describe "#fetch_with_top_three" do
    subject(:supplier_with_top_three) { described_class.fetch_with_top_three(slug) }

    let(:slug) { "smol-energy-inc" }

    around do |example|
      ClimateControl.modify(USE_TEST_SUPPLIERS: "true") do
        VCR.use_cassette("supplier/fetch_with_top_three", match_requests_on: [:method]) do
          example.run
        end
      end
    end

    it { is_expected.to be_present }
    its(:size) { is_expected.to be 4 }

    it "returns the requested supplier" do
      expect(supplier_with_top_three.map(&:name)).to include "Smol Energy Inc"
    end

    it "returns the suppliers in order" do
      expect(supplier_with_top_three.map(&:rank)).to eql [901, 902, 903, 906]
    end
  end

  describe "a ranked supplier" do
    subject { build(:supplier, :ranked) }

    context "when FF_CSR_NEW_DATA is enabled" do
      around do |example|
        ClimateControl.modify(FF_NEW_CSR_DATA: "true") do
          example.run
        end
      end

      its(:complaints_rating) { is_expected.to eq 4.3 }
    end

    context "when FF_CSR_NEW_DATA is disabled" do
      around do |example|
        ClimateControl.modify(FF_NEW_CSR_DATA: "false") do
          example.run
        end
      end

      its(:complaints_rating) { is_expected.to eq 4 }
    end

    its(:name) { is_expected.to eq "An Energy Supplier Inc" }
    its(:slug) { is_expected.to eq "an-energy-supplier-inc" }
    its(:rank) { is_expected.to eq 1 }
    its(:complaints_number) { is_expected.to eq 172 }
    its(:contact_email) { is_expected.to eq 89 }
    its(:contact_rating) { is_expected.to eq 2.3 }
    its(:contact_social_media) { is_expected.to eq "01:15:00" }
    its(:contact_time) { is_expected.to eq "00:03:27" }
    its(:guarantee_rating) { is_expected.to eq 3 }
    its(:overall_rating) { is_expected.to eq 4.8 }
    its(:id) { is_expected.to eq "an-energy-supplier-inc" }

    it { is_expected.to be_top_three }
    it { is_expected.to be_persisted }
    it { is_expected.to be_ranked }
  end

  describe "an unranked supplier" do
    subject { build(:supplier) }

    its(:rank) { is_expected.to be_nil }
    it { is_expected.not_to be_ranked }
    it { is_expected.not_to be_top_three }
  end
end
