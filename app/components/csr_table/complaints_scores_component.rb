# frozen_string_literal: true

module CsrTable
  class ComplaintsScoresComponent < ViewComponent::Base
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
        {
          term: content_tag(:p, "Complaints to Citizens Advice, Advice Direct Scotland and the Energy Ombudsman"),
          description: content_tag(:p, "#{supplier.complaints_number} per 10,000 customers")
        }
      ]
    end
  end
end
