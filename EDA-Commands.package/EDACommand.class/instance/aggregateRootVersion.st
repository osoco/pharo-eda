accessing
aggregateRootVersion
  | result |
  result := aggregateRootVersion.
  result ifNil: [ result := 1. self aggregateRootVersion: result ].
  ^ result