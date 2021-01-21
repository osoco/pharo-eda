"
I'm a stub to provide logging via EDATLogging to target classes we cannot change directly.

I'm expected to be used by extension methods to use EDATLogging.

I rely on EDATLogging to provide logging to target classes.

Example:

To add EDATLogging-based logging to ZnLogEvent class, add an extension method such as
""*EDA-Logging""
logToStdout
	self stopLoggingToTranscript.
	^ self announcer when: ZnLogEvent do: [ :event | EDATLoggingStub new logInfoMessage: event ]
"
Class {
	#name : #EDALoggingStub,
	#superclass : #Object,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#category : 'EDA-Traits'
}
