accessing
assertMatches: anArray
	| result |
	result := true.
	anArray doWithIndex: [ :item :i | result := result and: [ self assertItemMatches: item at: i ] ].
	^ result