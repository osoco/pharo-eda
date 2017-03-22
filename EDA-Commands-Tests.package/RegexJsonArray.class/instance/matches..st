as yet unclassified
matches: anArray
	| result |
	result := true.
	anArray doWithIndex: [ :item :i | result := result and: [ self itemMatches: item at: i ] ].
	^ result