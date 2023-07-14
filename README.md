# Property SCM plugin

Use this configuration with **ElectricSentry** to watch for property
changes.

# Configuration

Create a source control configuration, and supply the following
information:

-   **Configuration Name** - Provide a unique name for the
    configuration. Keep in mind, you may need to create additional
    configurations over time.

-   **Description** - Supply a text description for your reference only.
    CloudBees CD/RO does not use this information.

# Using the plugin

## Configuring a build for property

A Trigger Property **ElectricSentry** schedule is not based on an SCM
system, but instead based on monitoring a CloudBees CD/RO property. The
property can be defined anywhere in CloudBees CD/RO, but your
"CloudBees" project must have access to it.

If the property is defined using "relative property path" syntax, it is
assumed the property is in the same project as the schedule, either in
the project directly or in a property sheet within the project.

The property can be set by the successful completion of a CloudBees
CD/RO job, by a trigger generated from an SCM system, or by any other
internal or external process that has access to the CloudBees CD/RO API.
Examples:

-   `/projects/Master Build/buildCompetionTime`: As an absolute path.

-   `componentBuildCount`: As a relative path.

For each configured user schedule, **ElectricSentry** looks for settings
in the UI, and CloudBees CD/RO stores these values in the following
property locations:

-   Project: `userProject`

-   Schedule: `userSchedule`

-   Property Sheet: `ec_custom EditorData`

## Trigger property settings

-   `TriggerPropertyName`: This is the name of the property to monitor.

-   `QuietTimeMinutes`: This is a property set by **ElectricSentry**.
    For the `Trigger Property`, **ElectricSentry** records the value of
    the property.

-   `LastAttemptedSnapshot`: This is a property set by
    **ElectricSentry**. For the `File Property`, ElectricSentry records
    a time-string based on the file modify time.

## Operation details

**ElectricSentry** retrieves the status of the specified file and tests
whether it has changed since the last build time.

`Quiet time`, which is set through a field on the individual schedule or
globally on the **SentryMonitor** schedule, is calculated by testing
files\` modify date. The date which the file was last modified is
compared to the **ElectricSentry** machine system time. If
`QuietTimeMinutes` time has elapsed, the job will start. Otherwise,
**ElectricSentry** continues to test quiet time each time it runs until
quiet time is met.

# Release notes

## ECSCM-Property 2.0.5

The documentation has been migrated to the main documentation site.
(Deprecated.)

## ECSCM-Property 2.0.4

CloudBees Flow to CloudBees CD/RO rebranding.

## ECSCM-Property 2.0.3

Renaming to "CloudBees".

## ECSCM-Property 2.0.2

-   Added help link to the Sentry form.

## ECSCM-Property 2.0.1

-   Updated help page format.

## ECSCM-Property 2.0.0

-   Updated help page format.

## ECSCM-Property 1.0.2

-   Updated help page.

## ECSCM-Property 1.0.0

-   SCM features - Sentry.

-   SCM features - Configuration.
