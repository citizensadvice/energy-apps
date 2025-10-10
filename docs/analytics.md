# Analytics

## Google Analytics

Google Analytics 4 is added via Google Tag Manager and is loaded on all pages.

## Google Tag Manager

[Google Tag Manager](https://developers.google.com/tag-platform/tag-manager/web) is loaded on all pages once a user has consented to analytics cookies.

There is a script loaded in the `<head>` at [shared/\_head_analytics.html.haml](../app/views/shared/_head_analytics.html.haml) and a `<noscript>` variant loaded in the `<body>` at [shared/\_google_tag_manager_no_script.html.haml](../app/views/shared/_google_tag_manager_no_script.html.haml).

## Analytics configuration by app
### Energy Customer Service Ratings Table
Special gtm classes have been added to certain elements in order to facilitate better analytics.

The inclusion of class `gtm-supplier-table-row` means that we can track how many users click on 'More details' for a specific supplier.

Class `gtm-select-unranked-supplier` allows us to track how many users search for an unranked supplier. We would not be able to track this behaviour without this class, as the unranked supplier information opens in the main supplier table page.

Finally, class `gtm-show-more-suppliers` allows us to track interactions with the 'Show more suppliers' button on the mobile view of the main supplier table page. By default only the top 5 suppliers are displayed on mobile view, and users can click 'Show more suppliers' if they want to see the full table.

No bespoke gtm events have been created for the CSR table.  

### Appliance Calculator
The appliance calculator uses custom GTM events to track user engagement with the tool. When debugging in GTM you should use the URL of the iframe i.e. `/appliance-calculator` rather than the advice collection in which it is embedded.

#### DataLayer Variables
| Description                            | Event                               | Value                                            | Example Values                                           |
|----------------------------------------|-------------------------------------|--------------------------------------------------|----------------------------------------------------------|
| Next button clicked                    | `app_calc_next_button_click`        | The name of the step on when clicked             | `appliance`, `time_usage`, `cyclical_usage`, `unit_rate` |
| Previous button clicked                | `app_calc_previous_button_click`    | The name of the step on when clicked             | `appliance`, `time_usage`, `cyclical_usage`, `unit_rate` |
| Add another appliance clicked          | `app_calc_add_another_appliance`    | Fixed text                                       | `add_another_appliance_click`                            |
| Clear list clicked                     | `app_calc_clear_list`               | Fixed text                                       | `clear_list_click`                                       |
| Most expensive appliance message shown | `app_calc_most_expensive_appliance` | The name of the appliance that is most expensive | `TEST _ Fan heater`, `TEST _ Tumble dryer (condenser)`   |
| Appliance added to the list            | `app_calc_appliance_added`          | The message shown in the green box               | `TEST _ Fan heater added to the list below`              |
| An error is displayed                  | `app_calc_form_error`               | The error message                                | `Select an appliance from the list`                      |

#### Analytics Reports
An [exploration report has been set up to display appliance calculator data](https://analytics.google.com/analytics/web/#/analysis/p284911746/edit/Lf8bsW4-RDSKqB0-K7W2pg).

You can get to it from the main page by following: `Explore` > `Appliance Calculator`.

There are five tabs in the exploration:
1. **Events** - shows total count of all of the tracked events, broken down by event.
2. **Form navigation** - shows total number of `Next` and `Previous` button clicks, broken down by form step (see form url to step table below).
3. **Errors** - lists all the unique error messages logged and count
4. **Added appliances** - lists all the added appliances logged and count
5. **Most expensive** - lists all the most expensive appliance messages displayed and count

##### Form url to step
The exploration report only shows URLs. These can be converted into steps using the table below:

| URL                                                                    | Step             |
|------------------------------------------------------------------------|------------------|
| /appliance-calculator/daily_usage_creation/steps/appliance?no-js=false | Appliance        |
| /appliance-calculator/daily_usage_creation/steps/time_usage            | Usage (time)     |
| /appliance-calculator/daily_usage_creation/steps/unit_rate             | Unit rate        |
| /appliance-calculator/daily_usage_creation/steps/appliance             | Appliance        |
| /appliance-calculator/daily_usage_creation/steps/cyclical_usage        | Usage (cyclical) |