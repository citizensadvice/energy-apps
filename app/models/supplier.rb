# frozen_string_literal: true

class Supplier
  include ActiveModel::Model

  attr_accessor :data

  delegate :name, :whitelabel_supplier, :slug, :rank,
           :complaints_number, :contact_email, :contact_rating,
           :contact_social_media, :contact_time, :contact_info,
           :other_contact_info, :billing_info, :guarantee_rating,
           :guarantee_list, :overall_rating, :data_available, :fuel_mix,
           :opening_hours, :bill_accuracy_and_metering_rating,
           :bills_accuracy_smart, :bills_accuracy_traditional,
           :smart_operating, :contact_webchat_sync, :contact_webchat_async,
           :contact_whatsapp_sync, :contact_whatsapp_async,
           :contact_in_app_sync, :contact_in_app_async,
           :contact_sms_sync, :contact_sms_async, :contact_portal_sync,
           :contact_portal_async, to: :data

  def self.fetch_all
    response = Contentful::Graphql::Client.query(Queries::Suppliers)

    response.data.energy_supplier_collection.items.map do |item|
      Supplier.new(data: item)
    end
  end

  def self.fetch_with_top_three(slug)
    response = Contentful::Graphql::Client.query(Queries::SupplierDetail, variables: { slug: })

    response.data.energy_supplier_collection.items.map do |item|
      Supplier.new(data: item)
    end
  end

  def ranked?
    data.data_available
  end

  # these methods allow us to use helpers like `link_to` and `form_for``
  def id
    slug
  end

  def persisted?
    slug.present?
  end

  def top_three?
    return false if rank.blank?

    rank.positive? && rank < 4
  end

  def complaints_rating
    Feature.enabled?("FF_NEW_CSR_DATA") ? data.complaints_rating_score : data.complaints_rating
  end
end
