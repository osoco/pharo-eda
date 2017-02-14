lifecycle
start
	self busListener
		subscribe;
		onMessageDo: [ :message | self consumeCommandMessage: message ]