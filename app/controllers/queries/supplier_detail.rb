# frozen_string_literal: true

module Queries
  SupplierDetail = Contentful::Graphql::Client.parse <<-GRAPHQL
  query($top_three_ranks: [Int], $tag_filter: ContentfulMetadataTagsFilter, $slug: String) {
    energySupplierCollection (
      order:rank_ASC,
      where: {
        contentfulMetadata:{ tags: $tag_filter },
        OR: [
        	{slug: $slug},
          {rank_in: $top_three_ranks}
        ]
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
        billAccuracyAndMeteringRating,
        billsAccuracySmart,
        billsAccuracyTraditional,
        smartOperating,
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
        }
      }
    }
  }
  GRAPHQL
end
