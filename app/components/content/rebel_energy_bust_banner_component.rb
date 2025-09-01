# frozen_string_literal: true

module Content
  class RebelEnergyBustBannerComponent < ViewComponent::Base
    def initialize(supplier:, current_country: nil)
      super()
      @supplier = supplier
      @current_country = current_country
    end

    def render?
      # show on the main table page
      return true if @supplier.blank?

      # show on the rebel energy details page
      @supplier.id == "rebel-energy"
    end

    def link
      "#{country_prefix}/consumer/energy/energy-supply/problems-with-your-energy-supply/your-energy-supplier-has-gone-bust/"
    end

    private

    attr_reader :supplier, :current_country

    def country_prefix
      return if current_country.blank? || current_country == "england"

      "/#{current_country}"
    end
  end
end
