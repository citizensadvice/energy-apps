# frozen_string_literal: true

module CsrTable
  class ScoreSummaryComponent < ViewComponent::Base
    attr_reader :supplier, :quarter_date

    delegate :scores_fragment, to: :helpers

    def initialize(supplier, quarter_date)
      super()
      @supplier = supplier
      @quarter_date = quarter_date
    end

    def render?
      supplier.present?
    end
  end
end
