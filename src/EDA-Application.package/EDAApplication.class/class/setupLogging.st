setup
setupLogging
	EDALogEvent announcer subscribe: EDALogEvent do: [ :event | self logInfoMessage: event greaseString ]