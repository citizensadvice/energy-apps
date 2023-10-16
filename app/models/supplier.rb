# frozen_string_literal: true

class Supplier
  include ActiveModel::Model

  attr_accessor :data

  delegate :name, :whitelabel_supplier, :slug,
           :rank, :complaints_rating, :complaints_number,
           :contact_email, :contact_rating, :contact_time, :contact_info,
           :contact_social_media, :billing_info, :guarantee_list, :guarantee_rating,
           :overall_rating, :data_available,
           :fuel_mix, :opening_hours, to: :data

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
end
