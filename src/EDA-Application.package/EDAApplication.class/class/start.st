api
start
	self setup.
	self isStarted
		ifTrue: [ ^ self ].
	self commandConsumer start.
	self isStarted: true