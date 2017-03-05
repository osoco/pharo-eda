comparing
matches: aCollection
	| intersect |
	intersect := aCollection associationsSelect: [ :assoc | (self associationAt: assoc key) isNotNil ].
	^ intersect size = aCollection size
		ifTrue: [ | result |
			result := true.
			intersect associationsDo: [ :assoc | result := result and: [ self associationMatches: assoc ]].
			^ result ]
		ifFalse: [ ^ false ]