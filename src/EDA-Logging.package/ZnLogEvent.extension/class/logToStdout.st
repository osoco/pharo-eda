*EDA-Logging
logToStdout
	self stopLoggingToTranscript.
	^ self announcer when: ZnLogEvent do: [ :event | EDALoggingStub new logInfoMessage: event ]