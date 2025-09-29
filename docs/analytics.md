# Analytics

## Google Analytics

Google Analytics 4 is added via Google Tag Manager and is loaded on all pages.

## Google Tag Manager

[Google Tag Manager](https://developers.google.com/tag-platform/tag-manager/web) is loaded on all pages once a user has consented to analytics cookies.

There is a script loaded in the `<head>` at [shared/\_head_analytics.html.haml](../app/views/shared/_head_analytics.html.haml) and a `<noscript>` variant loaded in the `<body>` at [shared/\_google_tag_manager_no_script.html.haml](../app/views/shared/_google_tag_manager_no_script.html.haml).

### Energy Customer Service Ratings Table
Special gtm classes have been added to certain elements in order to facilitate better analytics.

The inclusion of class `gtm-supplier-table-row` means that we can track how many users click on 'More details' for a specific supplier.

Class `gtm-select-unranked-supplier` allows us to track how many users search for an unranked supplier. We would not be able to track this behaviour without this class, as the unranked supplier information opens in the main supplier table page.

Finally, class `gtm-show-more-suppliers` allows us to track interactions with the 'Show more suppliers' button on the mobile view of the main supplier table page. By default only the top 5 suppliers are displayed on mobile view, and users can click 'Show more suppliers' if they want to see the full table.

No bespoke gtm events have been created for the CSR table.  

### Appliance Calculator
