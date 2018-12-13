Class

- I am a trait that injects logging methods for any class to use.

Responsibility

- I provide a simple logging mechanism, avoiding polluting Transcript logic everywhere.

Collaborators

- I delegate the logging to Transcript.

Public API and Key Messages

- logDebugMessage: logs a message under the "DEBUG" category. Only 10% of these messages get logged instantly.
- logErrorMessage: logs a message under the "ERROR" category, instantly.
- logErrorMessage:andThrow: logs a message under the "ERROR" category  and throws an exception, instantly.
- logInfoMessage: logs a message under the "INFO" category, instantly.
- logWarningMessage: logs a message under the "WARN" category, instantly.

To use me, you just need to "use" me. I'm a trait.

Internal Representation and Key Implementation Points.

I'm a trait, so I don't have state. This means I'm pretty limited unless I can access to an external entity I could use to customize my behavior.
So far such entity doesn't exist, and meanwhile I log everything to Transcript and flush it inmediately, but for DEBUG messages. Such messages get flushed every once in 10, in average.