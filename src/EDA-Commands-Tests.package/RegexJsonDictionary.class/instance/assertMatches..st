asserting
assertMatches: aDictionary
	| result |
	result := true.
	aDictionary associationsDo: [ :assoc | result := result and: [ self assertAssociationMatches: assoc ] ].
	^ result