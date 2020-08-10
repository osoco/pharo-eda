helper
bothAreCollections: myAttr andTheirContentsMatch: otherAttr
	| result |
	result := myAttr isCollection and: [ otherAttr isCollection ].
	result ifTrue: [ result := myAttr asOrderedCollection = otherAttr asOrderedCollection  ].
	^ result