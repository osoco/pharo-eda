helper
retrieveCommandAttributesBut: excluded
	| result attrs |
	attrs := self retrieveCommandAttributes.
	result := attrs select: [ :attr | (excluded includes: attr) not ].
	^ result
