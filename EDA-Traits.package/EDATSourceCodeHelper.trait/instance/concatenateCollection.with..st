helper
concatenateCollection: aCollection with: aSeparator
	| txt |
	txt := ''.
	aCollection
		doWithIndex: [ :item :i |
			i > 1
				ifTrue: [ txt := txt , aSeparator ].
			txt := txt , item ].
	^ txt