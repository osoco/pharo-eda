Class: EDACommandBuilderRegistry

This class holds the information about
which /builder/ is responsible of creating
which /command/.
By default, all commands get built by EDADefaultCommandBuilder,
unless the builder gets published in this registry.

Responsibility:

The only responsibility of this class
is to provide a way to retrieve the correct builder,
using the command name.

Public API:

- lookupBuilder: Retrieves the builder for a given command name.
- mapping: Allows registering custom builders.

Usage:

When a serialized command is received,
the corresponding /materializer/
uses this class to find out which /builder/ to use
in order to create the command instance
representing the request.