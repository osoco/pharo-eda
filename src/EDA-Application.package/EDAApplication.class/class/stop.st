api
stop
	self isStarted ifNil: [ self isStarted: false ].
	self isStarted
		ifFalse: [ ^ self ].
	self commandConsumer ifNotNil: [ :arg | arg stop ].
	self isStarted: false.
	self logInfoMessage: self applicationName , ' stopped'