"
* Class: EDAStompTopicListener

Manages the details of connecting, subscribing, and unsubscribing, to Stomp queues.

* Responsibility:

Contains the configuration settings used by Stomp clients, and manages basic operations such as subscribing and unsubscribing.

* Collaborators:

Children (not instances) of this class would be configured via the Settings framework .

* Public API and Key Messages

- subscribe:subscribe to a queue.
- unsubscribe: unsubscribe to a queue.
- subscriptionId: the id of the listener.
"
Class {
	#name : #EDAStompTopicListener,
	#superclass : #EDATopicListener,
	#traits : 'EDATPrintOnHelper + EDATErrorHelper',
	#classTraits : 'EDATPrintOnHelper classTrait + EDATErrorHelper classTrait',
	#instVars : [
		'client',
		'listenerProcess',
		'subscriptionId',
		'config'
	],
	#classInstVars : [
		'strategy',
		'username',
		'queue',
		'port',
		'host',
		'ack',
		'durable',
		'password',
		'prefetchCount',
		'timeout'
	],
	#category : #'EDA-StompMessaging'
}

{ #category : #accessing }
EDAStompTopicListener class >> ack [
	^ ack
]

{ #category : #accessing }
EDAStompTopicListener class >> ack: val [
	self assert: (#(#auto #client #'client-individual') includes: val).
	ack := val
]

{ #category : #accessing }
EDAStompTopicListener class >> destination [
	^ '/amq/queue/' , self queue
]

{ #category : #'class initialization' }
EDAStompTopicListener class >> doInitialize [
	self host: nil.
	self port: nil.
	self queue: nil.
	self username: nil.
	self password: nil.
	self timeout: nil.
	self prefetchCount: nil.
	self durable: true.
	self ack: #'client-individual'
]

{ #category : #accessing }
EDAStompTopicListener class >> durable [
	^ durable
]

{ #category : #accessing }
EDAStompTopicListener class >> durable: flag [
	durable := flag
]

{ #category : #accessing }
EDAStompTopicListener class >> host [
	^ host
]

{ #category : #accessing }
EDAStompTopicListener class >> host: val [ 
	host := val
]

{ #category : #'class initialization' }
EDAStompTopicListener class >> initialize [
	self doInitialize 
]

{ #category : #accessing }
EDAStompTopicListener class >> logMessageReceived: message usingClient: aClient from: aSource [
	self
		logInfoMessage:
			'Received message ' , message greaseString , ' in '
				, aSource greaseString , '.'
]

{ #category : #accessing }
EDAStompTopicListener class >> logReceivingMessage: message usingClient: aClient from: aSource [
	self
		logInfoMessage: 'Receiving message in ' , aSource greaseString , '.'
]

{ #category : #accessing }
EDAStompTopicListener class >> password [
	^ password
]

{ #category : #accessing }
EDAStompTopicListener class >> password: val [
	password := val
]

{ #category : #accessing }
EDAStompTopicListener class >> port [
	^ port
]

{ #category : #accessing }
EDAStompTopicListener class >> port: val [ 
	port := val
]

{ #category : #accessing }
EDAStompTopicListener class >> prefetchCount [
	^ prefetchCount
]

{ #category : #accessing }
EDAStompTopicListener class >> prefetchCount: val [
	prefetchCount := val
]

{ #category : #accessing }
EDAStompTopicListener class >> queue [
	^ queue
]

{ #category : #accessing }
EDAStompTopicListener class >> queue: val [
	queue := val
]

{ #category : #accessing }
EDAStompTopicListener class >> strategy [
	^ strategy
]

{ #category : #accessing }
EDAStompTopicListener class >> strategy: anObject [
	strategy := anObject
]

{ #category : #accessing }
EDAStompTopicListener class >> timeout [
	^ timeout
]

{ #category : #accessing }
EDAStompTopicListener class >> timeout: val [
	timeout := val
]

{ #category : #accessing }
EDAStompTopicListener class >> username [
	^ username
]

{ #category : #accessing }
EDAStompTopicListener class >> username: val [
	username := val
]

{ #category : #lifecycle }
EDAStompTopicListener >> asyncOnMessageDo: aBlock usingClient: aClient withConfig: aConfig andStrategy: aStrategy [
	| result |
	result := [ self
		syncOnMessageDo: aBlock
		usingClient: aClient
		withConfig: aConfig
		andStrategy: aStrategy ] newProcess.
	result priority: Processor systemBackgroundPriority.
	^ result
]

{ #category : #initialization }
EDAStompTopicListener >> buildClientWith: config [
	| result |
	result := StampClient new.
	result login: config username.
	result passcode: config password.
	result host: config host.
	result port: config port.
	result timeout: config timeout.
	^ result
]

{ #category : #accessing }
EDAStompTopicListener >> buildIdUsingClient: aClient withConfig: config [
	^ aClient nextId , '-', config destination
]

{ #category : #accessing }
EDAStompTopicListener >> client [
	^ client
]

{ #category : #accessing }
EDAStompTopicListener >> client: aClient [
	client := aClient
]

{ #category : #lifecycle }
EDAStompTopicListener >> close [
	[ self client close ]
		on: StampError , PrimitiveFailed, ZnIncomplete
		do: [ :ex |
			self
				logErrorMessage:
					(String
						streamContents: [ :s |
							s
								nextPutAll: 'Error closing Stamp connection: ';
								nextPutAll: ex greaseString ]) ]
]

{ #category : #accessing }
EDAStompTopicListener >> config [
	^ config
]

{ #category : #accessing }
EDAStompTopicListener >> config: aConfig [
	config := aConfig
]

{ #category : #lifecycle }
EDAStompTopicListener >> forceUnsubscribe [
	self subscriptionId: nil
]

{ #category : #initialization }
EDAStompTopicListener >> initialize [
	self config: self class.
	self client: (self buildClientWith: self config)
]

{ #category : #accessing }
EDAStompTopicListener >> listenerProcess [
	^ listenerProcess
]

{ #category : #accessing }
EDAStompTopicListener >> listenerProcess: aProcess [
	listenerProcess := aProcess
]

{ #category : #initialization }
EDAStompTopicListener >> logFinish: message usingClient: aClient withConfig: aConfig [
	self logInfoMessage: '<< Finished processing message: ', message greaseString , ' from ', aConfig queue greaseString , '.'
]

{ #category : #initialization }
EDAStompTopicListener >> logInit: message usingClient: aClient withConfig: aConfig [
	self logInfoMessage: '>> Processing incoming message: ', message greaseString , ' from ', aConfig queue greaseString , '.'

]

{ #category : #handling }
EDAStompTopicListener >> manageError: anException for: aCommandOrEvent usingErrorStrategy: aStrategy [
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
EDAStompTopicListener >> nextId [
	^ self buildIdUsingClient: self client withConfig: self config
]

{ #category : #lifecycle }
EDAStompTopicListener >> onMessageDo: aBlock [
	self
		listenerProcess:
			(self
				asyncOnMessageDo: aBlock
				usingClient: self client
				withConfig: self config
				andStrategy: self strategy).
	self listenerProcess resume.
	^ self listenerProcess
]

{ #category : #initialization }
EDAStompTopicListener >> resetClient [
	self client: (self buildClientWith: self config)
]

{ #category : #accessing }
EDAStompTopicListener >> strategy [
	^ self class strategy
]

{ #category : #lifecycle }
EDAStompTopicListener >> subscribe [
	self subscriptionId: self nextId.
	self subscribe: self subscriptionId usingClient: self client withConfig: self config.
	^ self subscriptionId
]

{ #category : #lifecycle }
EDAStompTopicListener >> subscribe: id usingClient: aClient withConfig: aConfig [
	| subscribeFrame ack |
	aClient open.
	subscribeFrame := StampSubscribeFrame new.
	subscribeFrame destination: aConfig destination.
	subscribeFrame persistent: aConfig durable.
	subscribeFrame id: id.
	subscribeFrame prefetchCount: aConfig prefetchCount.
	ack := aConfig ack.
	(ack = #auto) ifTrue: [ self logErrorMessage: 'ACK is auto. Resetting it to client-individual'. ack := #'client-individual'. ].
	subscribeFrame ack: ack.
	aClient writeWithReceipt: subscribeFrame	
]

{ #category : #accessing }
EDAStompTopicListener >> subscriptionId [
	^ subscriptionId
]

{ #category : #accessing }
EDAStompTopicListener >> subscriptionId: val [
	subscriptionId := val
]

{ #category : #enumerating }
EDAStompTopicListener >> syncOnMessageDo: aBlock usingClient: aClient withConfig: conf andStrategy: aStrategy [
	[ aClient
		runWith: [ :message | 
			| text |
			text := message body greaseString.
			self class
				logReceivingMessage: message body greaseString
				usingClient: aClient
				from: conf destination.
			[ | ack |
			aBlock value: text.
			ack := conf ack.
			ack = #'client-individual'
				ifFalse: [ self
						logErrorMessage:
							(String
								streamContents: [ :s | 
									s
										nextPutAll: 'ACK was ''';
										nextPutAll: conf ack greaseString;
										nextPutAll: ''' in ';
										nextPutAll: conf class greaseString;
										nextPutAll: '. Resetting it to client-individual.' ]).
					ack := #'client-individual' ].
			ack = #'client-individual'
				ifTrue: [ self logDebugMessage: 'Sending ACK...'.
					aClient writeWithReceipt: message ackFrame.
					self logDebugMessage: 'ACK sent.' ]
				ifFalse: [ self
						logErrorMessage:
							(String
								streamContents: [ :s | 
									s
										nextPutAll: 'Skipping ACK (type is ''';
										nextPutAll: conf ack greaseString;
										nextPut: $' ]) ].
			self class
				logMessageReceived: message body greaseString
				usingClient: aClient
				from: conf destination ]
				on: Error - Break
				do: [ :ex | 
					((ex isKindOf: StampError) and: ex messageText = 'AMQP channel died')
						ifTrue: [ ex signal ].
					self
						logErrorMessage:
							(String
								streamContents: [ :s | 
									s
										nextPutAll: 'Error consuming message: ';
										nextPutAll: ex description greaseString;
										nextPutAll: ' (';
										nextPutAll: thisContext stack last greaseString;
										nextPut: $) ]).
					conf ack = #'client-individual'
						ifTrue: [ | nack |
							self
								logDebugMessage:
									(String
										streamContents: [ :s | 
											s
												nextPutAll: 'Sending NACK message... ';
												nextPutAll: text greaseString;
												nextPut: $. ]).
							nack := message nackFrame.
							nack headers at: 'requeue' put: 'False'.
							aClient writeWithReceipt: nack.
							self
								logDebugMessage:
									(String
										streamContents: [ :s | 
											s
												nextPutAll: 'NACK message sent ';
												nextPutAll: text greaseString;
												nextPut: $. ]) ].
					self
						manageError: ex
						forMessage: text
						usingErrorStrategy: aStrategy ] ] ]
		on: PrimitiveFailed , StampError
		do: [ :ex | self logErrorMessage: ex greaseString.
			ex signal ]
]

{ #category : #lifecycle }
EDAStompTopicListener >> unsubscribe [
	^ self unsubscribe: self subscriptionId usingClient: self client
]

{ #category : #lifecycle }
EDAStompTopicListener >> unsubscribe: id usingClient: aClient [
	| unsubscribeFrame |
	listenerProcess
		ifNotNil: [ listenerProcess terminate.
			unsubscribeFrame := StampUnsubscribeFrame new id: id.
			aClient isConnected
				ifFalse: [ aClient open ].
			[ aClient writeWithReceipt: unsubscribeFrame ]
				on: Error
					do: [ "ignore this error" ].
			aClient close ]
]
