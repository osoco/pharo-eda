"
Class

- I am a trait that injects logging methods for any class to use.

Responsibility

- I provide a simple logging mechanism, avoiding polluting Transcript logic everywhere.

Collaborators

- I delegate the logging to Transcript.

Public API and Key Messages

- logDebugMessage: logs a message under the ""DEBUG"" category. Only 10% of these messages get logged instantly.
- logErrorMessage: logs a message under the ""ERROR"" category, instantly.
- logErrorMessage:andThrow: logs a message under the ""ERROR"" category  and throws an exception, instantly.
- logInfoMessage: logs a message under the ""INFO"" category, instantly.
- logWarningMessage: logs a message under the ""WARN"" category, instantly.

To use me, you just need to ""use"" me. I'm a trait.

Internal Representation and Key Implementation Points.

I'm a trait, so I don't have state. This means I'm pretty limited unless I can access to an external entity I could use to customize my behavior.
So far such entity doesn't exist, and meanwhile I log everything to Transcript and flush it inmediately, but for DEBUG messages. Such messages get flushed every once in 10, in average.
"
Trait {
	#name : #EDATLogging,
	#category : 'EDA-Traits'
}

{ #category : #logging }
EDATLogging classSide >> beautifyByDefault [
	^ true
]

{ #category : #logging }
EDATLogging classSide >> defaultStream [
	^ self stdout
]

{ #category : #logging }
EDATLogging classSide >> logDebugMessage: aMessage [
	^ self logDebugMessage: aMessage beautify: self beautifyByDefault
]

{ #category : #logging }
EDATLogging classSide >> logDebugMessage: aMessage beautify: aBoolean [
	EDALoggingSettings debugEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'DEBUG'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDATLogging classSide >> logErrorMessage: aMessage [
	^ self logErrorMessage: aMessage beautify: self beautifyByDefault
]

{ #category : #logging }
EDATLogging classSide >> logErrorMessage: aMessage andThrow: anExceptionClass [
	^ self logErrorMessage: aMessage beautify: self beautifyByDefault andThrow: anExceptionClass
]

{ #category : #logging }
EDATLogging classSide >> logErrorMessage: aMessage beautify: aBoolean [
	EDALoggingSettings errorEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'ERROR'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDATLogging classSide >> logErrorMessage: aMessage beautify: aBoolean andThrow: anExceptionClass [
	self logErrorMessage: aMessage beautify: aBoolean.
	anExceptionClass signal: aMessage
]

{ #category : #logging }
EDATLogging classSide >> logInfoMessage: aMessage [
	^ self logInfoMessage: aMessage beautify: self beautifyByDefault 
]

{ #category : #logging }
EDATLogging classSide >> logInfoMessage: aMessage beautify: aBoolean [
	EDALoggingSettings infoEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'INFO '
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDATLogging classSide >> logMessage: aMessage inCategory: aString inStream: aStream [
	^ self logMessage: aMessage inCategory: aString inStream: aStream beautify: self beautifyByDefault 
]

{ #category : #logging }
EDATLogging classSide >> logMessage: aMessage inCategory: aString inStream: aStream beautify: beautify [
	| timestamp stream |
	stream := WriteStream on: String new.
	beautify
		ifTrue: [ stream << '['.
			timestamp := DateAndTime now.
			timestamp printYMDOn: stream.
			stream << '|'.
			timestamp printHMSOn: stream.
			stream << ']['.
			stream << aString asUppercase.
			stream << '] ' ].
	aMessage ifNotNil: [ :msg | stream nextPutAll: msg ].
	beautify
		ifTrue: [ (aMessage endsWithSubCollection: '.')
				ifFalse: [ stream << '.' ] ].
	stream nextPut: Character cr.
	stream nextPut: Character lf.
	aStream
		<< stream contents;
		nextPut: Character cr.
	(aString = 'ERROR'
		or: [ aString = 'WARN ' or: [ aString = 'INFO ' or: [ DateAndTime now seconds % 10 = 0 ] ] ])
		ifTrue: [ aStream flush ]
]

{ #category : #logging }
EDATLogging classSide >> logTraceMessage: aMessage [
	^ self logTraceMessage: aMessage beautify: self beautifyByDefault 
]

{ #category : #logging }
EDATLogging classSide >> logTraceMessage: aMessage beautify: aBoolean [
	EDALoggingSettings traceEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'TRACE'
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDATLogging classSide >> logWarningMessage: aMessage [
	^ self logWarningMessage: aMessage beautify: self beautifyByDefault
]

{ #category : #logging }
EDATLogging classSide >> logWarningMessage: aMessage beautify: aBoolean [
	^ EDALoggingSettings warningEnabled
		ifTrue: [ self
				logMessage: aMessage
				inCategory: 'WARN '
				inStream: self defaultStream
				beautify: aBoolean ]
]

{ #category : #logging }
EDATLogging classSide >> nextPut: aCharacter [
	| result |
	result := self defaultStream.
	result nextPut: aCharacter.
	^ result
]

{ #category : #logging }
EDATLogging classSide >> nextPutAll: aString [
	| result |
	result := self defaultStream.
	result nextPutAll: aString.
	^ result
]

{ #category : #logging }
EDATLogging classSide >> print: aString [
	| result |
	result := self defaultStream.
	result print: aString.
	^ result
]

{ #category : #logging }
EDATLogging classSide >> stderr [
	^ Stdio stderr
]

{ #category : #logging }
EDATLogging classSide >> stdout [
	^ Stdio stdout
]

{ #category : #logging }
EDATLogging >> logDebugMessage: aMessage [
	^ self class logDebugMessage: aMessage
]

{ #category : #logging }
EDATLogging >> logDebugMessage: aMessage beautify: aBoolean [
	^ self class logDebugMessage: aMessage beautify: aBoolean
]

{ #category : #logging }
EDATLogging >> logErrorMessage: aMessage [
	^ self class logErrorMessage: aMessage
]

{ #category : #logging }
EDATLogging >> logErrorMessage: aMessage andThrow: anExceptionClass [
	^ self class logErrorMessage: aMessage andThrow: anExceptionClass
]

{ #category : #logging }
EDATLogging >> logErrorMessage: aMessage beautify: aBoolean [
	^ self class logErrorMessage: aMessage beautify: aBoolean
]

{ #category : #logging }
EDATLogging >> logErrorMessage: aMessage beautify: aBoolean andThrow: anExceptionClass [
	^ self class logErrorMessage: aMessage beautify: aBoolean andThrow: anExceptionClass
]

{ #category : #logging }
EDATLogging >> logInfoMessage: aMessage [
	^ self class logInfoMessage: aMessage
]

{ #category : #logging }
EDATLogging >> logInfoMessage: aMessage beautify: aBoolean [
	^ self class logInfoMessage: aMessage beautify: aBoolean
]

{ #category : #logging }
EDATLogging >> logTraceMessage: aMessage [
	^ self class logTraceMessage: aMessage
]

{ #category : #logging }
EDATLogging >> logTraceMessage: aMessage beautify: aBoolean [
	^ self class logTraceMessage: aMessage beautify: aBoolean
]

{ #category : #logging }
EDATLogging >> logWarningMessage: aMessage [
	^ self class logWarningMessage: aMessage
]

{ #category : #logging }
EDATLogging >> logWarningMessage: aMessage beautify: aBoolean [
	^ self class logWarningMessage: aMessage beautify: aBoolean
]

{ #category : #logging }
EDATLogging >> nextPut: aCharacter [
	^ self class nextPut: aCharacter
]

{ #category : #logging }
EDATLogging >> nextPutAll: aString [
	^ self class nextPutAll: aString
]

{ #category : #logging }
EDATLogging >> print: aString [
	^ self class print: aString
]
