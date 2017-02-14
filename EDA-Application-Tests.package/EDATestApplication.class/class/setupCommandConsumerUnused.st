lifecycle
setupCommandConsumerUnused
	| proxy |
	super setupCommandConsumer.
	proxy := SynchronizedStompTopicListener wrap: EDATestApplication commandConsumer busListener.
	EDATestApplication commandConsumer busListener: proxy.
	^ self