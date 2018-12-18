Class: EDAErrorAsEventStrategy

This strategy generates and publishes an event when an error is detected when processing a command.

Responsibility:

To produce an event representing the error detected.

Collaborators:

The settings framework is responsible to allow the user to choose among the available strategy implementations.

Public API and Key Messages:

See EDACommandErrorHandlingStrategy