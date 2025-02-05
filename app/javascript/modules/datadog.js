import { datadogLogs } from '@datadog/browser-logs'

const initDatadog = () => {
    const ddEnv = window.location.hostname === 'www.citizensadvice.org.uk' ? "prod" : "dev";
    const appVersion = document.querySelector('meta[name="app-version"]').getAttribute('content');

    if (ddEnv && appVersion) {
        datadogLogs.init({
            clientToken: 'pub32a7538113d7910e4304b8aa13ff4521', // this is a public token designed to be used in client side js
            site: 'datadoghq.eu',
            forwardErrorsToLogs: true,
            sessionSampleRate: 100,
            service: 'energy-apps',
            env: ddEnv,
            version: appVersion
        });
    }
}

export default initDatadog;
