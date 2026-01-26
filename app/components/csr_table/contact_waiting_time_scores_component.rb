# frozen_string_literal: true

module CsrTable
  class ContactWaitingTimeScoresComponent < ViewComponent::Base
    attr_reader :supplier, :renderer

    def initialize(supplier)
      super()
      @supplier = supplier
      @renderer = Renderers::RichTextRenderer.new
    end

    def render?
      supplier.present?
    end

    # Not all suppliers will provide data for each of the customer contact channels;
    # and if a supplier provides synchronous data then they won't provide
    # asynchronous data, and vice versa. We therefore need to determine which fields
    # to render based on whether there is a value present or not
    def descriptions
      descriptions = [
        contact_time,
        contact_email,
        sync_data,
        async_data
      ]
      descriptions.flatten.compact
    end

    def sync_data
      [
        webchat_sync,
        whatsapp_sync,
        sms_sync,
        in_app_sync,
        portal_sync
      ]
    end

    def async_data
      [
        webchat_async,
        whatsapp_async,
        sms_async,
        in_app_async,
        portal_async
      ]
    end

    def contact_time
      {
        term: content_tag(:p, "Average call centre wait time"),
        description: content_tag(:p, format_sync_output(supplier.contact_time))
      }
    end

    def contact_email
      {
        term: content_tag(:p, "Emails responded to within 2 days"),
        description: content_tag(:p, "#{supplier.contact_email}%")
      }
    end

    def format_sync_output(time_str)
      intervals = time_str.split(":").map(&:to_i)
      waiting_time_in_seconds = (intervals[0] * 60 * 60) + (intervals[1] * 60) + intervals[2]
      human_readable_time = ActiveSupport::Duration.build(waiting_time_in_seconds).inspect

      # Render the average waiting time in this format: 1 hour 56 minutes 23 seconds
      human_readable_time.gsub("and ", "").delete(",")
    end

    def webchat_sync
      return if supplier.contact_webchat_sync.blank?

      {
        term: content_tag(:p, "Average Webchat response time"),
        description: content_tag(:p, format_sync_output(supplier.contact_webchat_sync))
      }
    end

    def webchat_async
      return if supplier.contact_webchat_async.blank?

      {
        term: content_tag(:p, "Webchat messages responded to within 2 days"),
        description: content_tag(:p, "#{supplier.contact_webchat_async}%")
      }
    end

    def whatsapp_sync
      return if supplier.contact_whatsapp_sync.blank?

      {
        term: content_tag(:p, "Average Whatsapp response time"),
        description: content_tag(:p, format_sync_output(supplier.contact_whatsapp_sync))
      }
    end

    def whatsapp_async
      return if supplier.contact_whatsapp_async.blank?

      {
        term: content_tag(:p, "Whatsapp messages responded to within 2 days"),
        description: content_tag(:p, "#{supplier.contact_whatsapp_async}%")
      }
    end

    def sms_sync
      return if supplier.contact_sms_sync.blank?

      {
        term: content_tag(:p, "Average SMS response time"),
        description: content_tag(:p, format_sync_output(supplier.contact_sms_sync))
      }
    end

    def sms_async
      return if supplier.contact_sms_async.blank?

      {
        term: content_tag(:p, "SMS messages responded to within 2 days"),
        description: content_tag(:p, "#{supplier.contact_sms_async}%")
      }
    end

    def in_app_sync
      return if supplier.contact_in_app_sync.blank?

      {
        term: content_tag(:p, "Average response time using the supplier's app"),
        description: content_tag(:p, format_sync_output(supplier.contact_in_app_sync))
      }
    end

    def in_app_async
      return if supplier.contact_in_app_async.blank?

      {
        term: content_tag(:p, "Messages responded to within 2 days using the supplier's app"),
        description: content_tag(:p, "#{supplier.contact_in_app_async}%")
      }
    end

    def portal_sync
      return if supplier.contact_portal_sync.blank?

      {
        term: content_tag(:p, "Average response time using a customer account portal"),
        description: content_tag(:p, format_sync_output(supplier.contact_portal_sync))
      }
    end

    def portal_async
      return if supplier.contact_portal_async.blank?

      {
        term: content_tag(:p, "Messages responded to within 2 days using a customer account portal"),
        description: content_tag(:p, "#{supplier.contact_portal_async}%")
      }
    end
  end
end
