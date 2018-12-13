accessing
assertAssociationMatches: anAssociation
	| v |
	v := anAssociation value.
	(v isKindOf: Array)
		ifTrue: [ ^ (RegexJsonArray newFrom: (self dictAt: anAssociation key for: v andTestCase: self testCase)) assertMatches: v ]
		ifFalse: [ (v isKindOf: Dictionary)
				ifTrue: [ ^ (RegexJsonDictionary newFrom: (self dictAt: anAssociation key)) assertMatches: v ]
				ifFalse: [ | result |
					result := anAssociation key = 'id'
						ifTrue: [ true ]
						ifFalse: [ self string: v greaseString matchesRegex: (self at: anAssociation key) greaseString ].
					^ result ] ]