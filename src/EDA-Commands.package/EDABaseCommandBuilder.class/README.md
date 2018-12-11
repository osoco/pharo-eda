Class: EDABaseCommandBuilder

Base class for all command builders.

Responsibility:

It's responsible of providing common logic
useful when specialized builders
need to create commands.

Public API:

This class does not export any public API.
It does export some methods to be used by
its children, though.
- commandClassForName: to guess the class based on the command name.
- commandClassPrefix: the generic EDA class prefix.
- buildWith:/takes care of the commonalities of all commands.

Usage:

This class is not used directly.