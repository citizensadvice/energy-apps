// Entry point for the build script in your package.json
import initHeader from '@citizensadvice/design-system/lib/header';
import initGreedyNav from "./modules/greedy-nav";
import initSupplierTableButton from "./modules/supplier-table";
import initDatadog from "./modules/datadog";

try {
  // Initialise datadog monitoring
  initDatadog();

  // Initialise design-system modules
  initHeader();
  initGreedyNav();

  // Initialise application modules
  initSupplierTableButton();
} catch (error) {
  document.querySelector("html").classList.add("no-js");
  throw error;
}

throw new Error("This is a deliberate error from the energy apps javascript")
