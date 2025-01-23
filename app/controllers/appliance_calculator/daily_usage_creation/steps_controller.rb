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

      # unit rate is captured in the unit_rate step of the form, which is shown
      # only once during the first journey then saved into the session
      def saved_unit_rate
        session[:unit_rate]
      end
      helper_method :saved_unit_rate

      def wizard_store_key
        :daily_usage_creation
      end

      def on_complete(results)
        results => {usage:, rate:}

        session[:unit_rate] = rate
        session[:usages] ||= []
        session[:usages] << usage

        redirect_to appliance_calculator_daily_usage_creation_step_path("completed")
      end
    end
  end
end
