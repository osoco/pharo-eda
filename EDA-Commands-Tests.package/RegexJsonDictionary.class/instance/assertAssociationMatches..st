accessing
assertAssociationMatches: anAssociation
	| v |
	v := anAssociation value.
	self flag: #TODO.	"Fix for the Array values"
	(v isKindOf: Array)
		ifTrue: [ ^ (RegexJsonArray newFrom: (self dictAt: anAssociation key)) assertMatches: v ]
		ifFalse: [ (v isKindOf: Dictionary)
				ifTrue: [ ^ (RegexJsonDictionary newFrom: (self dictAt: anAssociation key)) assertMatches: v ]
				ifFalse: [ | result |
					result := anAssociation key = 'id'
						ifTrue: [ true ]
						ifFalse: [ self string: v greaseString matchesRegex: (self at: anAssociation key) greaseString ].
					^ result ] ]