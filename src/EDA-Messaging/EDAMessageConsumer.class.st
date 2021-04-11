Class {
	#name : #EDAMessageConsumer,
	#superclass : #Object,
	#traits : 'EDATPrintOnHelper + EDATErrorHelper',
	#classTraits : 'EDATPrintOnHelper classTrait + EDATErrorHelper classTrait',
	#instVars : [
		'busListener',
		'commandMaterializer',
		'commandDispatcher',
		'eventMaterializer',
		'eventDispatcher'
	],
	#classInstVars : [
		'restartOnCommandConsumingErrors',
		'restartOnEventConsumingErrors'
	],
	#category : #'EDA-Messaging-Consumers'
}

{ #category : #'instance creation' }
EDAMessageConsumer class >> busListener: busListener commandMaterializer: commandMaterializer commandDispatcher: commandDispatcher eventMaterializer: eventMaterializer eventDispatcher: eventDispatcher [
	^ self new
		busListener: busListener;
		commandMaterializer: commandMaterializer;
		commandDispatcher: commandDispatcher;
		eventMaterializer: eventMaterializer;
		eventDispatcher: eventDispatcher;
		yourself
]

{ #category : #'instance creation' }
EDAMessageConsumer class >> busListener: busListener materializer: commandMaterializer dispatcher: commandDispatcher [
	^ self new
		busListener: busListener;
		commandMaterializer: commandMaterializer;
		commandDispatcher: commandDispatcher;
		yourself
]

{ #category : #accessing }
EDAMessageConsumer class >> restartOnCommandConsumingErrors [
	^ restartOnCommandConsumingErrors
]

{ #category : #accessing }
EDAMessageConsumer class >> restartOnCommandConsumingErrors: aBoolean [
	restartOnCommandConsumingErrors := aBoolean
]

{ #category : #accessing }
EDAMessageConsumer class >> restartOnEventConsumingErrors [
	^ restartOnEventConsumingErrors
]

{ #category : #accessing }
EDAMessageConsumer class >> restartOnEventConsumingErrors: anObject [
	restartOnEventConsumingErrors := anObject
]

{ #category : #accessing }
EDAMessageConsumer >> busListener [
	^ busListener
]

{ #category : #accessing }
EDAMessageConsumer >> busListener: anObject [
	busListener := anObject
]

{ #category : #lifecycle }
EDAMessageConsumer >> close [
	self busListener close
]

{ #category : #accessing }
EDAMessageConsumer >> commandDispatcher [
	^ commandDispatcher
]

{ #category : #accessing }
EDAMessageConsumer >> commandDispatcher: anObject [
	commandDispatcher := anObject
]

{ #category : #accessing }
EDAMessageConsumer >> commandMaterializer [
	^ commandMaterializer
]

{ #category : #accessing }
EDAMessageConsumer >> commandMaterializer: anObject [
	commandMaterializer := anObject
]

{ #category : #reading }
EDAMessageConsumer >> consumeMessage: aMessageString [
	^ self
		consumeMessage: aMessageString
		usingStrategyForCommands: EDACommandConsumingErrorBehavior strategy andStrategyForEvents: EDAEventConsumingErrorBehavior strategy
]

{ #category : #reading }
EDAMessageConsumer >> consumeMessage: aMessageString usingStrategyForCommands: aStrategy andStrategyForEvents: anotherStrategy [
	| result aCommand commandFailed |
	commandFailed := false.
	[ aCommand := self commandMaterializer materialize: aMessageString.
	result := self commandDispatcher dispatch: aCommand usingStrategy: aStrategy ]
		on: Error
		do: [ commandFailed := true ].
	commandFailed
		ifTrue: [ | anEvent |
			anEvent := self eventMaterializer materialize: aMessageString.
			result := self eventDispatcher
				dispatch: anEvent
				usingStrategy: anotherStrategy ].
	^ result
]

{ #category : #accessing }
EDAMessageConsumer >> eventDispatcher [
	^ eventDispatcher
]

{ #category : #accessing }
EDAMessageConsumer >> eventDispatcher: anObject [
	eventDispatcher := anObject
]

{ #category : #accessing }
EDAMessageConsumer >> eventMaterializer [
	^ eventMaterializer
]

{ #category : #accessing }
EDAMessageConsumer >> eventMaterializer: anObject [
	eventMaterializer := anObject
]

{ #category : #helpers }
EDAMessageConsumer >> printOn: t1 [
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
EDAMessageConsumer >> restart [
	self logWarningMessage: 'Restarting Command Consumer..'.
	[ self stop ]
		ensure: [ self start ]
]

{ #category : #lifecycle }
EDAMessageConsumer >> start [
	| listener |
	self logWarningMessage: 'Starting Command Consumer...'.
	self busListener resetClient.
	listener := self busListener
		subscribe;
		onMessageDo: [ :message | self consumeMessage: message ].
	listener
		on: Exception - Break
		do: [ :error | 
			self
				manageError: error
				usingErrorStrategy: EDACommandConsumingErrorBehavior strategy.
			self class restartOnCommandConsumingErrors
				ifTrue: [ self restart ] ]
]

{ #category : #lifecycle }
EDAMessageConsumer >> stop [
	[ self busListener forceUnsubscribe.
	self logWarningMessage: 'Stopped Command Consumer.' ]
		on: Error
		do: [ :ex |
			self
				logErrorMessage: 'Error stopping Command Consumer: ' , ex description , '.' ]
]
