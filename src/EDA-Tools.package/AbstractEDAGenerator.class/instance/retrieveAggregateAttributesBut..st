helper
retrieveAggregateAttributesBut: excluded
	| result attrs |
	attrs := self retrieveAggregateAttributes.
	result := attrs select: [ :attr | (excluded includes: attr) not ].
	^ result