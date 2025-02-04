// Entry point for the build script in your package.json
import initHeader from '@citizensadvice/design-system/lib/header';
import initGreedyNav from "./modules/greedy-nav";
import initSupplierTableButton from "./modules/supplier-table";

try {
  // Initialise design-system modules first
  initHeader();
  initGreedyNav();

  // Initialise application modules
  initSupplierTableButton();
} catch (error) {
  document.querySelector("html").classList.add("no-js");
  throw error;
}
