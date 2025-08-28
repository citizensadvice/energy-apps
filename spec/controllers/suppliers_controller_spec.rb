# frozen_string_literal: true

require "rails_helper"

# rubocop:disable RSpec/NestedGroups
RSpec.describe SuppliersController do
  describe "#custom_data_layer_properties" do
    subject(:data_layer_properties) { controller.helpers.data_layer_properties }

    context "when the supplier is not set" do
      it {
        expect(data_layer_properties).to include(platform: "content-platform",
                                                 siteType: "Public Website",
                                                 pageTemplate: "Energy Customer Service Ratings Table",
                                                 pageType: "Energy Customer Service Ratings Table",
                                                 GUID: "energy-csr-table")
      }

      context "when FF_NEW_COOKIE_MANAGEMENT is enabled" do
        around do |example|
          ClimateControl.modify(FF_NEW_COOKIE_MANAGEMENT: "true") do
            example.run
          end
        end

        context "when a user has accepted analytics cookies" do
          before { allow(controller).to receive(:allow_analytics_cookies?).and_return(true) }

          it { is_expected.to have_key(:analyticsCookiesAccepted) }
        end

        context "when a user has rejected analytics cookies" do
          before { allow(controller).to receive(:allow_analytics_cookies?).and_return(false) }

          it { is_expected.not_to have_key(:analyticsCookiesAccepted) }
        end
      end

      context "when FF_NEW_COOKIE_MANAGEMENT is not enabled" do
        around do |example|
          ClimateControl.modify(FF_NEW_COOKIE_MANAGEMENT: "false") do
            example.run
          end
        end

        it { is_expected.not_to have_key(:analyticsCookiesAccepted) }
      end
    end

    context "when the supplier is set" do
      before do
        controller.instance_variable_set :@supplier, build(:supplier)
      end

      it {
        expect(data_layer_properties).to include(platform: "content-platform",
                                                 siteType: "Public Website",
                                                 pageTemplate: "Energy Customer Service Ratings - An Energy Supplier Inc",
                                                 pageType: "Energy Customer Service Ratings - An Energy Supplier Inc",
                                                 GUID: "energy-csr-an-energy-supplier-inc")
      }

      context "when FF_NEW_COOKIE_MANAGEMENT is enabled" do
        around do |example|
          ClimateControl.modify(FF_NEW_COOKIE_MANAGEMENT: "true") do
            example.run
          end
        end

        context "when a user has accepted analytics cookies" do
          before { allow(controller).to receive(:allow_analytics_cookies?).and_return(true) }

          it { is_expected.to have_key(:analyticsCookiesAccepted) }
        end

        context "when a user has rejected analytics cookies" do
          before { allow(controller).to receive(:allow_analytics_cookies?).and_return(false) }

          it { is_expected.not_to have_key(:analyticsCookiesAccepted) }
        end
      end

      context "when FF_NEW_COOKIE_MANAGEMENT is not enabled" do
        around do |example|
          ClimateControl.modify(FF_NEW_COOKIE_MANAGEMENT: "false") do
            example.run
          end
        end

        it { is_expected.not_to have_key(:analyticsCookiesAccepted) }
      end
    end
  end
end
# rubocop:enable RSpec/NestedGroups
