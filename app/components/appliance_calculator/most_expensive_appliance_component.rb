# frozen_string_literal: true

module ApplianceCalculator
  class MostExpensiveApplianceComponent < ViewComponent::Base
    def initialize(usages)
      @usages = usages
    end

    def render?
      @usages.present? && @usages.size > 1
    end

    def text
      "Your most expensive appliance in this list is your #{@usages.first['label']}"
    end
  end
end
