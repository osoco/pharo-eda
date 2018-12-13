API
wrap: aListener
	^ GHTargetBasedProxy createProxyFor: aListener handler: SynchronizedStompTopicListener new