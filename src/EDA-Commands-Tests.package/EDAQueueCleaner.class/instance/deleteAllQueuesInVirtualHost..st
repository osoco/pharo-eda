api
deleteAllQueuesInVirtualHost: vHost
	| queues result |
	queues := self listQueuesInVirtualHost: vHost.
	result := (queues anySatisfy: [ :q | (self deleteQueue: q inVirtualHost: vHost) not ]) not.
	^ result