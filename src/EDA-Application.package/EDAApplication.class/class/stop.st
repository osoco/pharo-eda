accessing
stop
	self isStarted
		ifFalse: [ ^ self ].
	self commandConsumer ifNotNil: [ :arg | arg stop ].
	self isStarted: false