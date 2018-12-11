This class generates (and compiles) all Command-related classes.

To use it for a new command (json example file under commands/BBVA-ATS/v1/ folder), proceed as follows:

| edaApplicationPrefix jsonFile generator aggregate |
edaApplicationPrefix := 'ATS'.
jsonFile := FileSystem workingDirectory / 'contracts' / 'BBVA-ATS' / 'v1' / 'commands' / 'update.round.example.json'.
aggregate := 'Round'.
generator := (EDAGenerator fromExampleFile: jsonFile appName: edaApplicationPrefix aggregate: aggregate).
generator generateAll