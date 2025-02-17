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

const initAnalytics = () => {
    trackClicks();
}

export default initAnalytics;
