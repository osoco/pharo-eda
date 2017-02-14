Class: EDADefaultCommandBuilder

This class knows how to build commands from a default map structure:

{
    'name' -> [commandName].
    'commandId' -> [commandId].
    'aggregateRootVersion' -> [rootVersion].
    'authorUsername' -> [author]. "optional"
    'params' -> {
        'applicationId' -> [appId],
        [..]
    } asDictionary.
    'timestamp' -> [timestamp].
} asDictionary.

It supports arbitrary contents within the /params/ dictionary,
as long as the command declares instance variables
for all entries contained therein.

Responsibility:

This class is responsible of building almost all OpenBadges commands,
since it's flexible enough to support command-specific contents.
For commands requiring custom code, a specialized builder would be required
instead of this class.

Public API:

- buildWith: Creates arbitrary commands following a fixed yet flexible approach.

Usage:

Just call /buildWith:/ with the map structure, and it'll return a new command
with all information already processed.