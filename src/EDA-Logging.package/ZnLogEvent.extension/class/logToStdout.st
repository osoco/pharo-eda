*EDA-Logging
logToStdout
	self stopLoggingToTranscript.
   	^ self announcer when: ZnLogEvent do: [ :event | EDATLoggingStub new logInfoMessage: event ]