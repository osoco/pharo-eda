Class {
	#name : #EDACommandConsumer,
	#superclass : #Object,
	#traits : 'EDAPrintOnHelper + EDATErrorHelper',
	#classTraits : 'EDAPrintOnHelper classTrait + EDATErrorHelper classTrait',
	#instVars : [
		'busListener',
		'commandMaterializer',
		'commandDispatcher'
	],
	#classInstVars : [
		'restartOnCommandConsumingErrors'
	],
	#category : #'EDA-Messaging-Command'
}

{ #category : #'instance creation' }
EDACommandConsumer class >> busListener: busListener commandMaterializer: commandMaterializer commandDispatcher: commandDispatcher [
	^ self new
		busListener: busListener;
		commandMaterializer: commandMaterializer;
		commandDispatcher: commandDispatcher;
		yourself
]

{ #category : #accessing }
EDACommandConsumer class >> restartOnCommandConsumingErrors [
	^ restartOnCommandConsumingErrors
]

{ #category : #accessing }
EDACommandConsumer class >> restartOnCommandConsumingErrors: aBoolean [
	restartOnCommandConsumingErrors := aBoolean
]

{ #category : #accessing }
EDACommandConsumer >> busListener [
	^ busListener
]

{ #category : #accessing }
EDACommandConsumer >> busListener: anObject [
	busListener := anObject
]

{ #category : #lifecycle }
EDACommandConsumer >> close [
	self busListener close
]

{ #category : #accessing }
EDACommandConsumer >> commandDispatcher [
	^ commandDispatcher
]

{ #category : #accessing }
EDACommandConsumer >> commandDispatcher: anObject [
	commandDispatcher := anObject
]

{ #category : #accessing }
EDACommandConsumer >> commandMaterializer [
	^ commandMaterializer
]

{ #category : #accessing }
EDACommandConsumer >> commandMaterializer: anObject [
	commandMaterializer := anObject
]

{ #category : #reading }
EDACommandConsumer >> consumeMessage: aCommandMessageString [
	^ self consumeMessage: aCommandMessageString usingStrategy: EDACommandConsumingErrorBehavior strategy
]

{ #category : #reading }
EDACommandConsumer >> consumeMessage: aCommandMessageString usingStrategy: aStrategy [
	| aCommand |
	aCommand := self commandMaterializer
		materialize: aCommandMessageString.
	^ self commandDispatcher dispatch: aCommand usingStrategy: aStrategy
]

{ #category : #testing }
EDACommandConsumer >> isConnected [
	^ self busListener isConnected
]

{ #category : #handling }
EDACommandConsumer >> notifyError: anException withTitle: errorTitle andProcessingMessage: aMessage andFuelContext: fuelContextFileReference [
	| fileName materializationScript |

	fileName := 'contestia-core-context-' , DateAndTime now asYYYYmmddHMS , '.fuel'.
	materializationScript := '(EDAFuelHelper new 
    readFuelFromFileNamed: ''' , fileName
		,
			''' asFileReference) 
        debug'.
	EDAErrorNotificationsDiscordConfig createClient
		embedColor: Color red;
		embedTitle: errorTitle;
		embedDescriptionMarkdown: [ :markdown | 
			markdown
				text: 'An exception';
				space;
				bold: anException class greaseString;
				space;
				text: 'detected'.
			aMessage
				ifNotNil: [ markdown space;
					text: 'processing the message:'; cr;
						script: (aMessage asString truncateWithElipsisTo: (DSConstants maxMessageLenght - 400)) language: 'json';
						cr ].
			markdown
				text:
					'Download the attached file and debug it evaluating the following expression in a Pharo image:';
				cr;
				script: materializationScript language: 'Smalltalk' ];
		fileName: fileName
			bytes: (fuelContextFileReference binaryReadStreamDo: [ :in | in contents ]);
		send
]

{ #category : #helpers }
EDACommandConsumer >> printOn: t1 [
	| t2 |
	t2 := ''.
	self class allInstVarNames
		do: [ :t4 | 
			t2 isEmpty
				ifTrue: [ t2 := '{ ' ]
				ifFalse: [ t2 := t2 , ', ' ].
			t2 := t2 , '"' , t4 , '": "' , (self instVarNamed: t4) asString , '"' ].
	t2 := t2 , ' }'.
	t1 nextPutAll: t2.
	^ self
]

{ #category : #lifecycle }
EDACommandConsumer >> restart [
	self logWarningMessage: 'Restarting Command Consumer..'.
	[ self stop ]
		ensure: [ self start ]
]

{ #category : #lifecycle }
EDACommandConsumer >> start [
	| listenerProcess |
	self logWarningMessage: 'Starting Command Consumer...'.
	self busListener resetClient.
	listenerProcess := self busListener
		subscribe;
		onMessageDo: [ :message | self consumeMessage: message ].
	listenerProcess
		on: Exception - Break
		do: [ :error | 
			self
				manageError: error
				usingErrorStrategy: EDACommandConsumingErrorBehavior strategy.
			self class restartOnCommandConsumingErrors
				ifTrue: [ self restart ] ].
	listenerProcess resume
]

{ #category : #lifecycle }
EDACommandConsumer >> stop [
	[ self busListener forceUnsubscribe.
	self logWarningMessage: 'Stopped Command Consumer.' ]
		on: Error
		do: [ :ex |
			self
				logErrorMessage: 'Error stopping Command Consumer: ' , ex description , '.' ]
]
