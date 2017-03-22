helper
asPharoSourceCode: anAttributeValue
	| result |
	(anAttributeValue isKindOf: Array)
		ifTrue: [ result := String cr , '#('.
			anAttributeValue
				doWithIndex: [ :item :i |
					i > 1
						ifTrue: [ result := result , '.' ].
					result := result , (self asPharoSourceCode: item) , String cr ].
			result := result , ') asOrderedCollection' ]
		ifFalse: [ (anAttributeValue isKindOf: Dictionary)
				ifTrue: [ result := String cr , 'Dictionary newFrom: {'.
					anAttributeValue keys
						doWithIndex: [ :item :i |
							i > 1
								ifTrue: [ result := result , '.' ].
							result := result , String cr , (self asPharoSourceCode: item) , ' -> ' , (self asPharoSourceCode: (anAttributeValue at: item)) , String cr ].
					result := result , '}' , String cr ]
				ifFalse: [ (anAttributeValue isKindOf: String)
						ifTrue: [ result := $' asString , anAttributeValue , $' asString ]
						ifFalse: [ result := anAttributeValue asString ] ] ].
	^ result