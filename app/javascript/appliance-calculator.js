try {
    window.parent.postMessage(
    {
      id: "#appliance_calculator",
      height: document.body.scrollHeight,
    },
    "*"
  );
} catch (error) {
  document.querySelector("html").classList.add("no-js");
  throw error;
}
