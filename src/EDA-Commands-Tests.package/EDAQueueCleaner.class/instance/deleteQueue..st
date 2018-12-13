api
deleteQueue: aQueue
	^ self deleteQueue: aQueue inVirtualHost: self class defaultVirtualHost
