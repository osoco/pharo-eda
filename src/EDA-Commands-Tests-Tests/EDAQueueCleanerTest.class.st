Class {
	#name : #EDAQueueCleanerTest,
	#superclass : #TestCase,
	#category : 'EDA-Commands-Tests-Tests'
}

{ #category : #tests }
EDAQueueCleanerTest class >> test_delete_queue [
	<script>
	| cleaner |
	cleaner := EDAQueueCleaner new.
	cleaner deleteQueue: 'myqueue@audit'
]

{ #category : #tests }
EDAQueueCleanerTest class >> test_retrieve_queue_names [
	<script>
	| cleaner queues |
	cleaner := EDAQueueCleaner new.
	queues := cleaner listQueues
]

{ #category : #tests }
EDAQueueCleanerTest >> test_delete_all_queues [
	self assert: (EDAQueueCleaner new deleteAllQueues)
]

{ #category : #tests }
EDAQueueCleanerTest >> test_list_queue_names [
	self assert: EDAQueueCleaner new listQueues isNotEmpty
]
