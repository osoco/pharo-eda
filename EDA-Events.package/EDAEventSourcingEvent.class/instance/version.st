accessing
version
  ^ version ifNil: [ self aggregateRootVersion  ] ifNotNil: [ :v | v ].