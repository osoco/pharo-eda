initialization
setupCommandConsumer
	| listener  |
	listener := EDACommandStompTopicListener new.
	self flag: #TODO. "Convert debug value into a project's setting"
	listener client debug: true.
	^ self setupCommandConsumerWithCommandListener: listener