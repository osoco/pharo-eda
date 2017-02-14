initialization
setupCommandConsumerWithCommandListener: listener
	| materializer |
	self flag: #TODO. "Convert debug value into a project's setting"
	listener client debug: true.
	materializer := EDAJsonCommandMaterializer new.
	self
		commandConsumer:
			(EDACommandConsumer busListener: listener commandMaterializer: materializer commandDispatcher: self commandDispatcher)