initialization
setupLogging
	EDALogEvent announcer
		subscribe: EDALogEvent
		do: [ :event |
			Transcript
				crShow: '[';
				show: event timestamp;
				show: '] ';
				show: event ]