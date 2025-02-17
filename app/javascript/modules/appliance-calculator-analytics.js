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

const initAnalytics = () => {
    trackClicks();
    trackRenders();
}

export default initAnalytics
