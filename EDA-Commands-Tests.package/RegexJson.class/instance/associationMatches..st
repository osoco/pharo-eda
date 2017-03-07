comparing
associationMatches: anAssociation
	| v |
	v := anAssociation value.
	self flag: #TODO. "Fix for the Array values"
	(v isKindOf: Array)
		ifTrue: [ ^ (RegexJson newFrom: ((self at: anAssociation key) first)) matches: v first ]
		ifFalse: [ (v isKindOf: Dictionary)
				ifTrue: [ ^ (RegexJson newFrom: (self at: anAssociation key)) matches: v ]
				ifFalse: [ | vr result |
					vr := self escapeRegex: (self at: anAssociation key) asString.
					result := v asString matchesRegex: vr.
					^ result ] ]