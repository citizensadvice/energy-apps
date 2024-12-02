# frozen_string_literal: true

module ApplianceCalculator
  module DailyUsageCreation
    class StepsController < ApplicationController
      include WizardSteps
      self.wizard_class = ::DailyUsageCreation::Wizard

      layout "appliance_calculator"

      after_action :set_headers

      def index
        @appliances = Appliance.fetch_all
      end

      private

      def set_headers
        response.headers["cache-control"] = "no-store"
      end

      def step_path(step = params[:id])
        appliance_calculator_daily_usage_creation_step_path(step)
      end

      def wizard_store_key
        :daily_usage_creation
      end

      def on_complete(daily_usage)
        Rails.logger.debug daily_usage.inspect
      end
    end
  end
end
