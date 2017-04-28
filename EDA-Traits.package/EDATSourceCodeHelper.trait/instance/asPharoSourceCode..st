helper
asPharoSourceCode: anAttributeValue
	| result cr |
	cr := String with: Character cr.
	(anAttributeValue isKindOf: Array)
		ifTrue: [ result := cr , '#('.
			anAttributeValue
				keysAndValuesDo: [ :i :item |
					i > 1
						ifTrue: [ result := result , '.' ].
					result := result , (self asPharoSourceCode: item) , cr ].
			result := result , ') asOrderedCollection' ]
		ifFalse: [ (anAttributeValue isKindOf: Dictionary)
				ifTrue: [ result := cr , 'Dictionary newFrom: {'.
					anAttributeValue keys
						keysAndValuesDo: [ :i :item |
							i > 1
								ifTrue: [ result := result , '.' ].
							result := result , cr , (self asPharoSourceCode: item) , ' -> '
								, (self asPharoSourceCode: (anAttributeValue at: item)) , cr ].
					result := result , '}' , cr ]
				ifFalse: [ result := (anAttributeValue isKindOf: String)
						ifTrue: [ $' greaseString , anAttributeValue , $' greaseString ]
						ifFalse: [ anAttributeValue greaseString ] ] ].
	^ result