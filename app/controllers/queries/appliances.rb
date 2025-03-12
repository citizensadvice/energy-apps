# frozen_string_literal: true

module Queries
  Appliances = Contentful::Graphql::Client.parse <<-GRAPHQL
  query($tag_filter: ContentfulMetadataTagsFilter) {
    applianceCollection (
      where: {
        contentfulMetadata:{ tags: $tag_filter }
      },
      order: [ category_ASC, name_ASC],
    ) {
      items {
        name
        category
        wattage
        usageType
        additionalUsage
        variantQuestion
        variantOptions
        sys {
          id
        }
      }
    }
  }
  GRAPHQL
end
