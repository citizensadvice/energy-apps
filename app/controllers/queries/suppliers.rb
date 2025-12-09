# frozen_string_literal: true

module Queries
  Suppliers = Contentful::Graphql::Client.parse <<-GRAPHQL
  query($tag_filter: ContentfulMetadataTagsFilter) {
    energySupplierCollection (
      order:rank_ASC,
      where: {
        contentfulMetadata:{ tags: $tag_filter }
      }
    ) {
      total,
      items {
        name,
        whitelabelSupplier {
          name
        },
        slug,
        rank,
        complaintsRating,
        complaintsRatingScore,
        complaintsNumber,
        contactEmail,
        contactRating,
        contactSocialMedia,
        contactTime,
        guaranteeRating,
        overallRating,
        dataAvailable,
        guaranteeList {
          json
        },
        contactInfo {
          json
        },
        otherContactInfo {
          json
        },
        billingInfo {
          json
        },
        fuelMix {
          json
        },
        openingHours {
          json
        },
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
