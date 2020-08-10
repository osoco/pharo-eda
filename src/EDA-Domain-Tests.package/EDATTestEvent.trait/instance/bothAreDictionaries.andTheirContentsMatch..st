helper
bothAreDictionaries: myAttr andTheirContentsMatch: otherAttr
	| result |
	result := myAttr isDictionary and: [ otherAttr isDictionary ].
	result
		ifTrue:
			[ result := myAttr asDictionary = otherAttr asDictionary ].
	^ result