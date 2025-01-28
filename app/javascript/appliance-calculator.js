import initErrorSummary from '@citizensadvice/design-system/lib/error-summary';
import initDismissNotice from "./last_added_appliance";

try {
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



