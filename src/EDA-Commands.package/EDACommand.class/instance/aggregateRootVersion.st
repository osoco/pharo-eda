accessing
aggregateRootVersion
  | result |
  result := aggregateRootVersion.
  result ifNil: [ result := 0. self aggregateRootVersion: result ].
  ^ result