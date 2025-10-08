# frozen_string_literal: true

module CsrTable
  class SupplierTableComponent < ViewComponent::Base
    attr_reader :suppliers, :highlight_supplier_with_slug

    delegate :current_country, to: :helpers

    def initialize(suppliers, highlight_supplier_with_slug: nil)
      super()
      @suppliers = suppliers
      @highlight_supplier_with_slug = highlight_supplier_with_slug
    end

    def show_more_button_classes
      base_button_classes << "js-show-more-suppliers" << "gtm-show-more-suppliers"
    end

    def show_fewer_button_classes
      base_button_classes << "js-show-fewer-suppliers"
    end

    def base_button_classes
      %w[
        cads-button
        cads-button__secondary
      ]
    end

    def count_text
      "Showing 5 of #{suppliers.size} suppliers"
    end
  end
end
