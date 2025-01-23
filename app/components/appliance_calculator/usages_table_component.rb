# frozen_string_literal: true

module ApplianceCalculator
  class UsagesTableComponent < ViewComponent::Base
    def initialize(usages:, unit_rate:)
      @usages = usages
      @unit_rate = unit_rate
    end
  end
end
