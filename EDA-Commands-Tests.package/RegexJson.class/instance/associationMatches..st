comparing
associationMatches: anAssociation
	| v |
	v := anAssociation value.
"	self halt."
	(v isKindOf: Dictionary) ifTrue: [
		^ (RegexJson newFrom: (self at: anAssociation key)) matches: v
		]
	ifFalse: [ | vr result |
	vr := (self at: anAssociation key) asString copyWithRegex: '<ANYTHING>' matchesReplacedWith: '(.*)'.
	result := v asString matchesRegex: vr.
	^ result ]