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
	#category : 'EDA-Messaging-Command'
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
EDACommandConsumer >> consumeCommandMessage: aCommandMessageString [
	| aCommand |
	aCommand := self commandMaterializer
		materialize: aCommandMessageString.
	self commandDispatcher dispatch: aCommand
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
	| listener |
	self logWarningMessage: 'Starting Command Consumer...'.
	self busListener resetClient.
	listener := self busListener
		subscribe;
		onMessageDo: [ :message | 
			self
				consumeCommandMessage: message ].
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
EDACommandConsumer >> stop [
	[ self busListener forceUnsubscribe.
	self logWarningMessage: 'Stopped Command Consumer.' ]
		on: Error
		do: [ :ex |
			self
				logErrorMessage: 'Error stopping Command Consumer: ' , ex description , '.' ]
]