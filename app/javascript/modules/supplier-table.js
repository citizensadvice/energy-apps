const selectors = {
  table: ".js-supplier-table",
  allRows: ".js-supplier-table tbody tr",
  rowSixUp: ".js-supplier-table tbody tr:nth-child(n + 6)",
  showMoreButton: ".js-show-more-suppliers",
  showFewerButton: ".js-show-fewer-suppliers",
  countText: ".js-supplier-table-count-text",
};

const totalRows = document.querySelectorAll(selectors.allRows).length;

const hideRows = () => {
  document.querySelectorAll(selectors.rowSixUp).forEach((row) => {
    row.classList.add("supplier-table__row--hidden");
  });
};

const showRows = () => {
  document.querySelectorAll(selectors.rowSixUp).forEach((row) => {
    row.classList.remove("supplier-table__row--hidden");
  });
};

const updateCountText = (showing) => {
  const countText = document.querySelector(selectors.countText);
  countText.innerHTML = `Showing ${showing} of ${totalRows} suppliers`;
};

const showMoreSuppliers = () => {
  const tableContainer = document.querySelector(".supplier-table--show-more");
  tableContainer.classList.remove("supplier-table--show-more");
  tableContainer.classList.add("supplier-table--show-fewer");

  updateCountText(totalRows);
  showRows();
  const showFewer = document.querySelector(selectors.showFewerButton);
  showFewer.focus({ focusVisible: true });
};

const showFewerSuppliers = () => {
  const tableContainer = document.querySelector(".supplier-table--show-fewer");
  tableContainer.classList.remove("supplier-table--show-fewer");
  tableContainer.classList.add("supplier-table--show-more");

  updateCountText(5);
  hideRows();
  const showMore = document.querySelector(selectors.showMoreButton);
  showMore.focus({ focusVisible: true });
};

const addButtonEventHandlers = () => {
  document
    .querySelector(selectors.showMoreButton)
    .addEventListener("click", showMoreSuppliers);

  document
    .querySelector(selectors.showFewerButton)
    .addEventListener("click", showFewerSuppliers);
};

export default () => {
  hideRows();
  addButtonEventHandlers();
};
