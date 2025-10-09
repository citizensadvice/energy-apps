# frozen_string_literal: true

module CsrTable
  module UnrankedSuppliers
    class StarsSummaryComponent < ViewComponent::Base
      delegate :star_ratings?, to: :helpers
      attr_reader :supplier

      def initialize(supplier)
        super()
        @supplier = supplier
      end

      def render?
        supplier.present? && star_ratings?(@supplier)
      end
    end
  end
end
