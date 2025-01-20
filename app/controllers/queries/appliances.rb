# frozen_string_literal: true

module Queries
  Appliances = Contentful::Graphql::Client.parse <<-GRAPHQL
  query($tag_filter: ContentfulMetadataTagsFilter) {
    applianceCollection (
      where: {
        contentfulMetadata:{ tags: $tag_filter }
      }
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
        contentfulMetadata {
          tags {
            id
          }
        }
      }
    }
  }
  GRAPHQL
end
