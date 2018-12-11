helper
retrieveEventAttributesBut: excluded
	| result attrs |
	attrs := self retrieveEventAttributes.
	result := attrs select: [ :attr | (excluded includes: attr) not ].
	^ result