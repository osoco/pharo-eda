as yet unclassified
extractLevels: aCollection
    "Extracts the levels from given list of maps"
    | result |
    result := { } asOrderedCollection.
    aCollection collect: [ :item | result add: (self extractLevel: item) ].
    ^ result