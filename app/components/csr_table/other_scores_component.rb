# frozen_string_literal: true

module CsrTable
  class OtherScoresComponent < ViewComponent::Base
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
        guarantee_list,
        complaints_number,
        bills_accuracy_smart,
        bills_accuracy_traditional,
        smart_operating
      ]
    end

    def guarantee_list
      {
        term: content_tag(:p, "Customer commitments"),
        description: guarantee_list_render
      }
    end

    def complaints_number
      {
        term: content_tag(:p, "Complaints to Citizens Advice, Advice Direct Scotland and the Energy Ombudsman"),
        description: content_tag(:p, "#{supplier.complaints_number} per 10,000 customers")
      }
    end

    def bills_accuracy_smart
      {
        term: content_tag(:p, "Bills accuracy (smart)"),
        description: content_tag(:p, "93.7%")
      }
    end

    def bills_accuracy_traditional
      {
        term: content_tag(:p, "Bills accuracy (traditional)"),
        description: content_tag(:p, "83.1%")
      }
    end

    def smart_operating
      {
        term: content_tag(:p, "Smart operating"),
        description: content_tag(:p, "98.5%")
      }
    end

    def guarantee_list_render
      renderer.render_without_breaks(supplier.guarantee_list)
    end
  end
end
