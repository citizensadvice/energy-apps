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
      descriptions = [
        guarantee_list,
        complaints_number,
        contact_time,
        contact_social_media,
        contact_email
      ]

      Feature.enabled?("FF_NEW_CSR_DATA") ? descriptions + enhanced_descriptions : descriptions
    end

    def enhanced_descriptions
      [
        bills_accuracy_traditional,
        bills_accuracy_smart,
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

    def contact_time
      {
        term: content_tag(:p, "Average call centre wait time (hours, minutes and seconds)"),
        description: content_tag(:p, supplier.contact_time)
      }
    end

    def contact_social_media
      {
        term: content_tag(:p, "Average response time to social media messages (hours, minutes and seconds)"),
        description: content_tag(:p, supplier.contact_social_media)
      }
    end

    def contact_email
      {
        term: content_tag(:p, "Emails responded to within 2 days"),
        description: content_tag(:p, "#{supplier.contact_email}%")
      }
    end

    def guarantee_list_render
      renderer.render_without_breaks(supplier.guarantee_list)
    end

    def bills_accuracy_traditional
      {
        term: content_tag(:p, "Bills accuracy (traditional meter)"),
        description: content_tag(:p, "#{supplier.bills_accuracy_traditional}%")
      }
    end

    def bills_accuracy_smart
      {
        term: content_tag(:p, "Bills accuracy (smart meter)"),
        description: content_tag(:p, "#{supplier.bills_accuracy_smart}%")
      }
    end

    def smart_operating
      {
        term: content_tag(:p, "Smart operating"),
        description: content_tag(:p, "#{supplier.smart_operating}%")
      }
    end
  end
end
