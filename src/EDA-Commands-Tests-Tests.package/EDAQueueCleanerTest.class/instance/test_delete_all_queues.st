tests
test_delete_all_queues
	self assert: (EDAQueueCleaner new deleteAllQueues)