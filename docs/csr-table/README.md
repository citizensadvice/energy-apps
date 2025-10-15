# Customer Service Ratings (CSR) Table

## Overview

Provides the main CSR table and the detail pages for the ratings shown on 
`/consumer/your-energy/get-a-better-energy-deal/compare-domestic-energy-suppliers-customer-service/`.

Controllers, views and components have been namespaced to `CsrTable`.

## Data

Data for the table is provided by the Energy Policy team, after a long process of consultation and data processing.  It is uploaded into 
Contentful via the [Contentful CSR Upload app](https://github.com/citizensadvice/contentful-csr-upload).

The data is updated quarterly, one quarter in arrears.  For example, the data for April to June is published in September/October.

The Digital Energy team liases with the Energy Policy to co-ordinate the upload, which is normally done by a content designer.  Sometimes the Energy Policy team get the data into a draft form a few weeks before the publishing date.  If possible, it's good to test this with the upload tool in the Content Playground environment, and flag any issues to the Digital Energy team.  These might include:
- typos in supplier names that show up as a name change in the upload tool
- missing data
- missing suppliers
- change from ranked to small suppliers or vice versa
- badly formatted data

## Contentful Entries

### Energy Suppliers

Contentful holds all the data shown on these pages in the `Energy Supplier` content type.  Like intranet content, test and production data are
both stored in the `master` Contentful environment.  The `test` tag in Contentful is used to distinguish between the two, and the
GraphQL query has a parameter injected based on the state of the `USE_TEST_SUPPLIERS` env var.

### Energy Table Content Patterns

The publishing dates on the table page are also stored in Contentful, but they are not updated as part of the upload tool process.  These need to be
updated manually by the Energy Team content designer.

#### Ids

The ids for the content patterns are set as class level constants in the `SuppliersController`.  


## Routing 

Requests for the app url above are routed by CloudFront to the the energy-apps origin here https://github.com/citizensadvice/content-platform-cdn-cdk/blob/b3495a38966050d5facdb5a346b2e1872c97170b/content_platform_cdn_constructs/cdn.py#L51

There is a dummy page in Contentful that makes the CSR table appear in the relevant index page.  This was set up with a `1` appended to the URL.  There are now redirects in the `content-platform-proxy` repo to handle this.




