Class: EDADebugErrorStrategy

This strategy launches the default debugger when an error is detected when processing a command.

Responsibility:

To launch the debugger to help figuring out how to fix bugs.

Collaborators:

The settings framework is responsible to allow the user to choose among the available strategy implementations.

Public API and Key Messages:

See EDACommandErrorHandlingStrategy