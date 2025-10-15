# DataDog JS Monitoring

Errors in client side javascript are reported into DataDog as they occur.  They appear as logs rather than traces - [you can see an example here](https://app.datadoghq.eu/logs?query=status%3Aerror%20service%3Aenergy-apps&agg_m=count&agg_m_source=base&agg_t=count&cols=host%2Cservice&event=AwAAAZnjxh5sNy-DsQAAABhBWm5qeGk2a0FBQ0NTb2JWTTJZWDZRQUEAAAAkMTE5OWU0NGUtZTU2Zi00NjRiLWJmZjgtYmUyODRiZTFjZjg1AAA7ow&messageDisplay=inline&refresh_mode=sliding&storage=hot&stream_sort=desc&viz=stream&from_ts=1757935353081&to_ts=1760527353081&live=true).

## How does it work?

There is a [Browser Log SDK for datadog](https://docs.datadoghq.com/logs/log_collection/javascript/?tab=npm), which is included in the app's bundled js.  This catches client side errors and reports them to datadog using a public key and an app version number.  You can see this in `app/javascript/modules/datadog.js`.  The key is configured in the DataDog UI.  Note that we don't do any real-time user monitoring (RUM), which would have some privacy implications.

During deployment, we upload the app's unminified js along with the app version number to datadog.  This allows DataDog to display the source js alongside the error log.  This is done in the `upload-js-to-datadog.yaml` GitHub action workflow.

The app version is an environment variable injected into the container during the deployment process (it is the same as the docker image tag).  It's rendered into a `meta` tag in the `head` of both the appliance calculator and the CSR table, which is how the js picks it up to send to datadog.

## Data redaction

Network IPs and query string parameters are now redacted from `energy-apps` logs - this is configured in the [log pipeline](https://app.datadoghq.eu/logs/pipelines).

## Other notes

There are some [notes on the implementation of this in Confluence](https://citizensadvice.atlassian.net/wiki/spaces/NP/pages/4495769664/Javascript+Error+Logging+in+DataDog), which highlight the differences between this app and other apps in the content platform portoflio (mostly public website).

There are details of how this affects the app's front end build process in the [static asset pipeline readme](./static-asset-pipeline.md).
