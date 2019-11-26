logging
flushPendingLog
	self pendingLog ifNotNil: [ :col | col do: [ :line | self logDebugMessage: line beautify: false ] ].
	self pendingLog: OrderedCollection new