accessing
environment
	(environment isNil or: [ environment isEmpty ])
		ifTrue: [ environment := nil. environment := super environment ].
	^ environment