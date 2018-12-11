accessing
associationAt: key
	| result |
	result := key = 'id'
		ifTrue: [ '(.*)' ]
		ifFalse: [ self dict associationAt: key ifAbsent: [ ^ key -> '(.*)' ] ].
	^ result