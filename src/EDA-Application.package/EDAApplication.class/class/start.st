api
start
	self setup.
	self isStarted ifNil: [ self isStarted: false ].
	self isStarted
		ifTrue: [ ^ self ].
	self commandConsumer start.
	self isStarted: true