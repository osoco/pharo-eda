reset - commands
resetCommandConsumer
	self commandConsumer ifNotNil: [ :c | c close ].
	self commandConsumer: nil