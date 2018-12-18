Class: EDAJustLoggingProjectionErrorHandlingStrategy

This class represents a concrete strategy when dealing with errors detected when projecting events.

Responsibility:

Any strategy must extend this class and implement #handleError:.

Collaborators:

Any EDAProjector processing events should react upon errors by retrieving the selected strategy and delegating the error to it.
The Settings framework allows the user to review and choose among all defined strategies.

Public API and Key Messages:

- handleError: to deal with the error itself.
- description (class side): to describe the main purpose of the strategy.