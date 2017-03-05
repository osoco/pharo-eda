comparing
associationMatches: anAssociation
	| v vr result |
	v := anAssociation value asString.
	vr := (self at: anAssociation key) asString copyWithRegex: '<ANYTHING>' matchesReplacedWith: '(.*)'.
	result := v matchesRegex: vr.
	^ result.