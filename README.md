# Energy Apps

This repo contains one app that provides functionality for two small digital energy products - the appliance calculator and the customer
service ratings (CSR) table.

[ADR 8](./docs/adrs/0008-appliance-calculator-location.md) provides the context and reasoning co-locating the applicance calculator with the CST table, which should be revisited if the header and footer content and authentication functionality of public website are extracted into the design system or other library. 

The docs below apply to this app.  There is additional, product specific documentation in [csr-table](./docs/csr-table) and [appliance-calculator](./docs/appliance-calculator).

## Getting started

See [getting-started.md](./docs/getting-started.md)

## Environment variables & secrets

Environment variables and secrets are stored within the relevant environment(s) in the GitHub repo, not in Vault. See [configuration section in Infrastructure docs.](./infrastructure/README.md#configuration)

## View components

This project uses view components for front end logic and rendering - see [view-components.md](./docs/view-components.md)

## Static assets

See [static-assets-pipeline.md](./docs/static-asset-pipeline.md).

## GraphQL Queries

See [working-with-queries.md](./docs/working-with-queries.md).

## Test data

This repo contains [example data for automated testing](./spec/cassettes/supplier) .  The scores and energy suppliers mentioned in the data are not real.

For the latest energy supplier customer service ratings, see the Citizens Advice website. [https://www.citizensadvice.org.uk/consumer/your-energy/get-a-better-energy-deal/compare-domestic-energy-suppliers-customer-service/](https://www.citizensadvice.org.uk/consumer/your-energy/get-a-better-energy-deal/compare-domestic-energy-suppliers-customer-service/)
