Class {
	#name : #EDAMessageConsumer,
	#superclass : #Object,
	#traits : 'EDATPrintOnHelper + EDATErrorHelper',
	#classTraits : 'EDATPrintOnHelper classTrait + EDATErrorHelper classTrait',
	#instVars : [
		'busListener',
		'materializer',
		'dispatcher',
		'strategy'
	],
	#classInstVars : [
		'restartOnCommandConsumingErrors',
		'restartOnEventConsumingErrors'
	],
	#category : #'EDA-Messaging-Consumers'
}

{ #category : #'instance creation' }
EDAMessageConsumer class >> busListener: aBusListener materializer: aMaterializer dispatcher: aDispatcher strategy: aStrategy [
	^ self new
		busListener: aBusListener;
		materializer: aMaterializer;
		dispatcher: aDispatcher;
		strategy: aStrategy
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

{ #category : #reading }
EDAMessageConsumer >> consumeMessage: aMessageString [
	^ self
		consumeMessage: aMessageString
		usingStrategy: self strategy
]

{ #category : #reading }
EDAMessageConsumer >> consumeMessage: aMessageString usingStrategy: aStrategy [
	^ self dispatcher dispatch: (self materializer materialize: aMessageString) usingStrategy: aStrategy 
]

{ #category : #accessing }
EDAMessageConsumer >> dispatcher [
	^ dispatcher
]

{ #category : #accessing }
EDAMessageConsumer >> dispatcher: anObject [
	dispatcher := anObject
]

{ #category : #handling }
EDAMessageConsumer >> manageError: anException for: aCommandOrEvent usingErrorStrategy: aStrategy [
	| errorHandler result context basename dictionary |
	errorHandler := (self class environment at: aStrategy asSymbol) new.
	errorHandler class shouldPersistFuel
		ifTrue: [ self
				logErrorMessage:
					'Error processing ' , aCommandOrEvent greaseString , ': '
						, anException description greaseString.
			context := thisContext clone.
			basename := self class basename.
			self
				writeFuelContext: context
				named: anException class greaseString
				withBasename: basename.
			self write: aCommandOrEvent withBasename: basename ].
	errorHandler context: context.
	dictionary := Dictionary new.
	dictionary at: #commandOrEvent put: aCommandOrEvent.
	result := errorHandler
		handleError: anException
		withExtraContextInformation: dictionary.
	^ result
]

{ #category : #accessing }
EDAMessageConsumer >> materializer [
	^ materializer
]

{ #category : #accessing }
EDAMessageConsumer >> materializer: anObject [
	materializer := anObject
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

{ #category : #accessing }
EDAMessageConsumer >> strategy [
	^ strategy
]

{ #category : #accessing }
EDAMessageConsumer >> strategy: anObject [
	strategy := anObject
]
