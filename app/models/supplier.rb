# frozen_string_literal: true

class Supplier
  include ActiveModel::Model

  attr_accessor :data

  delegate :name, :slug, :rank, :previous_rank, :complaints_rating, :complaints_number, :contact_email, :contact_rating, :contact_time,
           :bills_rating, :bills_accuracy, :overall_rating, :data_available, to: :data

  def self.fetch_all
    response = Contentful::Graphql::Client.query(Queries::Suppliers)

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
end
