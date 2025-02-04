import initErrorSummary from '@citizensadvice/design-system/lib/error-summary';
import initDismissNotice from "./modules/last_added_appliance";
import initDatadog from "./modules/datadog";

try {
    // Initialise datadog monitoring
    initDatadog();
    
    initErrorSummary();
    window.parent.postMessage(
    {
      id: "#appliance_calculator",
      height: document.body.scrollHeight,
    },
    "*"
  );
    initDismissNotice()
} catch (error) {
  document.querySelector("html").classList.add("no-js");
  throw error;
}



