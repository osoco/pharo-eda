setup
setupLogging
	EDALogEvent announcer
		when: EDALogEvent
		do: [ :event | self logInfoMessage: event greaseString ]