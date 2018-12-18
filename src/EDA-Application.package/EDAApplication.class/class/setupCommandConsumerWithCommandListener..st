initialization
setupCommandConsumerWithCommandListener: listener
	| materializer |
	listener client debug: self commandListenerClientDebug.
	materializer := EDAJsonCommandMaterializer new.
	self
		commandConsumer: (EDACommandConsumer busListener: listener commandMaterializer: materializer commandDispatcher: self commandDispatcher)