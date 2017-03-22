as yet unclassified
associationMatches: anAssociation
	| v |
	v := anAssociation value.
	self flag: #TODO.	"Fix for the Array values"
	(v isKindOf: Array)
		ifTrue: [ ^ (RegexJsonArray newFrom: (self dictAt: anAssociation key)) matches: v ]
		ifFalse: [ (v isKindOf: Dictionary)
				ifTrue: [ ^ (RegexJsonDictionary newFrom: (self dictAt: anAssociation key)) matches: v ]
				ifFalse: [ | vr result |
					vr := self escapeRegex: (self at: anAssociation key) asString.
					result := v asString matchesRegex: vr.
					^ result ] ]