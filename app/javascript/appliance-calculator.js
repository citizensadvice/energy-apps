import initErrorSummary from '@citizensadvice/design-system/lib/error-summary';
import initDismissNotice from "./modules/last_added_appliance";
import initDatadog from "./modules/datadog";
import initAnalytics from "./modules/appliance-calculator-analytics"
import resizeIframe from "./modules/resize-iframe";

try {
    // Initialise datadog monitoring
    initDatadog();
    resizeIframe();
    initErrorSummary();
    initAnalytics();
    initDismissNotice()
} catch (error) {
  document.querySelector("html").classList.add("no-js");
  throw error;
}



