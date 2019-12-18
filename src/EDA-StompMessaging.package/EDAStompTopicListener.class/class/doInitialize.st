class initialization
doInitialize
	self host: nil.
	self port: nil.
	self queue: nil.
	self username: nil.
	self password: nil.
	self timeout: nil.
	self prefetchCount: nil.
	self durable: true.
	self ack: #'client-individual'