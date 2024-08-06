# frozen_string_literal: true

module UnrankedSuppliers
  class StarsSummaryComponent < ViewComponent::Base
    delegate :star_ratings?, to: :helpers
    attr_reader :supplier

    def initialize(supplier)
      @supplier = supplier
    end

    def render?
      supplier.present? && star_ratings?(@supplier)
    end
  end
end
