helper
allAttributesOf: cls including: attributes
	| result |
	result := OrderedCollection withAll: attributes.
	result addAll: cls instVarNames.
	^ (Set withAll: result) asOrderedCollection 