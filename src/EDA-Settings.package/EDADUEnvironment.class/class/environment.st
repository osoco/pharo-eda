accessing
environment
	(environment isNil or: [ environment isEmpty ])
		ifTrue: [ environment := nil.
			environment := super environment ].
	self logInfoMessage: 'Running in ', environment printString.
	^ environment