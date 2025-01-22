# frozen_string_literal: true

module ApplianceCalculator
  module DailyUsageCreation
    class StepsController < ApplicationController
      include WizardSteps
      self.wizard_class = ::DailyUsageCreation::Wizard

      layout "appliance_calculator"
      default_form_builder ::CitizensAdviceFormBuilder::FormBuilder

      after_action :set_headers

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

      def on_complete(usage)
        Rails.logger.info usage.inspect
      end
    end
  end
end
