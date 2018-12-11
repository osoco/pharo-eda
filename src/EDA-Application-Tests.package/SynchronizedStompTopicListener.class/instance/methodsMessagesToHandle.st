lifecycle
methodsMessagesToHandle
	| result |
	result := super methodsMessagesToHandle.
	result at: #onMessageDo: put: #handleOnMessageDo:.
	result at: #ready put: #eventsReady.
	result at: #ready: put: #eventsReady:.
	^ result