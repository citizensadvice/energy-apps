// Events are pushed into the datalayer here
// Events and values are defined on components directly in the rendered HTML



const trackClicks = () => {
    const trackedElements = document.querySelectorAll("[data-gtm-event='click']")
    if (trackedElements) {
        trackedElements.forEach(el => el.addEventListener('click', () => {
            window.dataLayer.push({
                event: el.getAttribute('data-gtm-event-name'),
                value: el.getAttribute('data-gtm-value')
            })
        }))
    }
}

const trackRenders = () => {
    const trackedElements = document.querySelectorAll("[data-gtm-event='render']")
    if (trackedElements) {
        trackedElements.forEach(el =>
            window.dataLayer.push({
                event: el.getAttribute('data-gtm-event-name'),
                value: el.getAttribute('data-gtm-value')
            })
        );
    }
}

const trackErrors = () => {
    const errors = document.querySelectorAll('.js-error-summary-link');
    errors.forEach(error => {
        window.dataLayer.push({
            event: "Form error",
            value: error.innerText
        })
    })
}

const initAnalytics = () => {
    trackClicks();
    trackRenders();
    trackErrors();
}

export default initAnalytics
