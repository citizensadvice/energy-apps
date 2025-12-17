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
        complaints_number
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

    def guarantee_list_render
      supplier.guarantee_list ? renderer.render_without_breaks(supplier.guarantee_list) : "None"
    end
  end
end
