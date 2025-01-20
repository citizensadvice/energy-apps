# frozen_string_literal: true

class Appliance
  include ActiveModel::Model

  attr_accessor :data

  delegate :name, :category, :wattage, :usage_type, :additional_usage, to: :data

  def self.fetch_all
    response = Contentful::Graphql::Client.query(Queries::Appliances)

    response.data.appliance_collection.items.map do |item|
      Appliance.new(data: item)
    end
  end

  def id
    data.sys.id
  end

  def cyclical?
    usage_type == "Cycles"
  end

  def variants?
    data["variantOptions"].present?
  end

  def variant_question
    return unless variants?

    data["variantQuestion"]
  end

  def variant_options
    return unless variants?

    options = data.dig("variantOptions", "tableData")
    # the first item in the array is the column headers in Contentful (eg ["option", "wattage"])
    # so we can drop it
    options.drop(1).map do |variant|
      FormOption.new(text: variant[0], value: variant[1])
    end
  end
end
