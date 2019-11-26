accessing
logVerbose: aString
	self pendingLog ifEmpty: [ self pendingLog: OrderedCollection new ].
	self pendingLog add: aString