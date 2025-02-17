// Events are pushed into the datalayer here
// Events and values are defined on components directly in the rendered HTML



const trackClicks = () => {
    const trackedElements = document.querySelectorAll("[data-gtm-event='click']")
    if (trackedElements) {
        trackedElements.forEach(el => el.addEventListener('click', () => {
            const event = el.getAttribute('data-gtm-event-name');
            const value = el.getAttribute('data-gtm-value');

            window.dataLayer.push({
                [event]: value
            });
        }))
    }
}

const trackRenders = () => {
    const trackedElements = document.querySelectorAll("[data-gtm-event='render']")
    if (trackedElements) {
        trackedElements.forEach(el => {
            const event = el.getAttribute('data-gtm-event-name');
            const value = el.getAttribute('data-gtm-value');

            window.dataLayer.push({
                [event]: value
            });
        })
    }
}

const trackErrors = () => {
    const errors = document.querySelectorAll('.js-error-summary-link');
    errors.forEach(error => {
        window.dataLayer.push({
            "app-calc-form-error": error.innerText
        })
    })
}

const initAnalytics = () => {
    trackClicks();
    trackRenders();
    trackErrors();
}

export default initAnalytics
