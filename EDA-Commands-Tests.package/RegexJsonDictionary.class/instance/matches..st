as yet unclassified
matches: aDictionary
	| result |
	result := true.
	aDictionary associationsDo: [ :assoc | result := result and: [ self associationMatches: assoc ] ].
	^ result