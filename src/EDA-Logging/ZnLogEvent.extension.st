Extension { #name : #ZnLogEvent }

{ #category : #'*EDA-Logging' }
ZnLogEvent class >> logToStdout [
	self stopLoggingToTranscript.
	^ self announcer when: ZnLogEvent do: [ :event | EDALoggingStub new logInfoMessage: event ]
]
