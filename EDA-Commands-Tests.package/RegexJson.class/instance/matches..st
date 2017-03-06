comparing
matches: aCollection
	| result |
	result := true.
	aCollection associationsDo: [ :assoc | result := result and: [ self associationMatches: assoc ]].
	^ result
