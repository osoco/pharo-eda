api
start
	self setup.
	self isStarted ifNil: [ self isStarted: false ].
	self isStarted
		ifTrue: [ ^ self ].
	self logSettings.
	self commandConsumer
		ifNotNil: [ :c | 
			c start.
			self isStarted: true ].
	self logInfoMessage: self applicationName , ' started'