# frozen_string_literal: true

module CsrTable
  class BillingAndMeteringScoresComponent < ViewComponent::Base
    attr_reader :supplier, :renderer

    def initialize(supplier)
      super()
      @supplier = supplier
      @renderer = Renderers::RichTextRenderer.new
    end

    def render?
      supplier.present?
    end

    def descriptions
      [
        bills_accuracy_smart,
        bills_accuracy_traditional,
        smart_operating
      ]
    end

    def bills_accuracy_smart
      {
        term: content_tag(:p, "Bills accuracy (smart meters) "),
        description: content_tag(:p, "#{supplier.bills_accuracy_smart}%")
      }
    end

    def bills_accuracy_traditional
      {
        term: content_tag(:p, "Bills accuracy (traditional meters)"),
        description: content_tag(:p, "#{supplier.bills_accuracy_traditional}%")
      }
    end

    def smart_operating
      {
        term: content_tag(:p, "Smart meters working correctly"),
        description: content_tag(:p, "#{supplier.smart_operating}%")
      }
    end
  end
end
