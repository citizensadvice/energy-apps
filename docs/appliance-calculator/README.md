# The Appliance Calculator

## Overview

The Appliance Calculator allows users to enter the appliances wish to compare, how long they use them for and how much they pay for
their electricity. It then provides a table ordered from most to least expensive.

Controllers, views and components have been scoped to the `ApplianceCalculator` namespace.

## Form

The app uses the `wizard_steps` gem to provide the multi-step form functionality to create a `DailyUsage` object. These are stored in the
session (up to a maximum of 10) and rendered into the `UsagesTableComponent`.

## Interactive Tool Iframe

The app is iframed into an advice page using the `InteractiveToolRenderer` in the public-website repo. A content type exists in Contentful that represents a tool and allows it to be embedded into an advice collection. The renderer in public website then creates and renders an `InteractiveToolComponent`, which is essentially an `iframe` with a `src` that points to this application.

The iframe is resized as instructed by the `postMessage` sent to the `parent` window via the js in the `app/javascript/modules/resize-iframe.js` module.

There are some more notes in the public website docs: [interactive tool docs](https://github.com/citizensadvice/public-website/blob/f019add8aac688659f61548afcff727811d281d4/docs/advice/interactive-tools.md?plain=1#L1).

## Contentful Entries

### Appliances

Appliances in the app are represented by the `Appliance` content type. Like intranet content, test and production data are both stored in the `master` Contentful environment. The `test` tag in Contentful is used to distinguish between the two.

Details of the model fields and their meanings can be found in the energy team's Google Drive: https://docs.google.com/document/d/1WhrKpLv7HiOKMuSQ_APuD38Pi6w3ouiY7AvZsjTMQQs/edit?usp=sharing

#### Cyclical & Time Based Appliances

There are two types of appliance: cyclical and time based.  Cyclical appliances have fixed consumptions each time they are used, like a washing machine.  Time based usages have variable consumptions that depend on how long they are used for, like a TV.  The `CyclicalDailyUsage` and `TimeBasedDailyUsage` objects contain the logic for working out `kWh` consumption based on the data entered by the user.

## Updating the unit rate

The calculator shows a default unit rate for electricity, so that a user doesn't have to find theirs when using the tool.  This is updated
quarterly to reflect changes in the national average.

It's stored as a config value in [pence per kWh as a config value](../../config/application.rb)

The digital energy team will ask in advance of when the change needs to happen.

## Useful docs

[Appliance calculator analytics summary](https://docs.google.com/document/d/1XHtGyj5pdbtWv-5etS1h5l9g0LHWwzLCbnPM2Y65qCs/edit?tab=t.0)
[Appliance calculator content model](https://docs.google.com/document/d/1WhrKpLv7HiOKMuSQ_APuD38Pi6w3ouiY7AvZsjTMQQs/edit?tab=t.0#heading=h.502rkuylsq6b)
[Appliance cost calcs (washing machines)](https://docs.google.com/document/d/1E7pd5Q16FF0sHoev2Dd3_n1DdCLz2w9y_E9I_gJijmg/edit?tab=t.0)
[Appliance cost calcs (ovens)](https://docs.google.com/document/d/1E7pd5Q16FF0sHoev2Dd3_n1DdCLz2w9y_E9I_gJijmg/edit?tab=t.0)
