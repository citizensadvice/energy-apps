const resizeIframe = () => {
    window.parent.postMessage(
        {
            id: "#appliance_calculator",
            height: document.body.scrollHeight + 5,
        },
        "*"
    );
}

export default resizeIframe;
