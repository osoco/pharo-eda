Class {
	#name : #EDAHandler,
	#superclass : #Object,
	#traits : 'EDATPrintOnHelper + EDATErrorHelper + EDATRepository',
	#classTraits : 'EDATPrintOnHelper classTrait + EDATErrorHelper classTrait + EDATRepository classTrait',
	#instVars : [
		'eventStore',
		'eventBus',
		'projectorClass'
	],
	#category : #'EDA-Handlers-Handlers'
}

{ #category : #'instance creation' }
EDAHandler class >> newFromEventStore: anEventStore eventBus: anEventBus andProjectorClass: aClass [
	^ self new
		eventStore: anEventStore;
		eventBus: anEventBus;
		projectorClass: aClass;
		yourself
]

{ #category : #accessing }
EDAHandler >> eventBus [
	^ eventBus
]

{ #category : #accessing }
EDAHandler >> eventBus: anObject [
	eventBus := anObject
]

{ #category : #accessing }
EDAHandler >> eventStore [
	^ eventStore
]

{ #category : #accessing }
EDAHandler >> eventStore: anObject [
	eventStore := anObject
]

{ #category : #accessing }
EDAHandler >> handle: arg1 withErrorStrategy: arg2 [ 
	^ self subclassResponsibility
]

{ #category : #handling }
EDAHandler >> invokeMethodHandlerWith: anObject on: aReceiver [
	self
		logDebugMessage:
			(String
				streamContents: [ :s | 
					s
						nextPutAll: 'Handling ';
						nextPutAll: anObject class greaseString ]).
	^ aReceiver perform: self handlerMethod selector with: anObject
]

{ #category : #handling }
EDAHandler >> manageError: anException for: aCommandOrEvent usingErrorStrategy: aStrategy [
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

{ #category : #'event processing' }
EDAHandler >> processGeneratedEvents: producedEvents for: aCommandOrEvent onAggregateRoot: anAggregateRoot [
	| message versionedEvents |
	message := ''.
	producedEvents
		do: [ :event | message := message , ' ' , event class name ].
	self
		logInfoMessage: 'Produced event(s): ' , message greaseString , '.'.
	self flag: #TODO.	"TODO: transaction including eventstore and eventbus operations"
	versionedEvents := self class
		addVersionToEvents: producedEvents
		usingEventStore: eventStore.
	eventStore saveEvents: versionedEvents.
	self logInfoMessage: 'Projecting events...'.
	(self projectorClass
		ofTenant: aCommandOrEvent tenant
		withAllProjectorsAndEventStore: eventStore)
		projectFilteredEvents: versionedEvents
		ofTenant: aCommandOrEvent tenant.
	self logInfoMessage: 'Done'.
	^ producedEvents
]

{ #category : #'event processing' }
EDAHandler >> processGeneratedProjections: producedProjections for: aCommandOrEvent onAnticorruptionLayer: anAnticorruptionLayer [
	| message |
	message := WriteStream with: String new.
	producedProjections
		do: [ :projection | 
			message
				nextPut: Character space;
				nextPutAll: projection class greaseString ].
	self
		logInfoMessage: 'Produced projections(s): ' , message contents greaseString , '.'.
	self logInfoMessage: 'Projecting ...'.
	(self projectorClass
		ofTenant: aCommandOrEvent tenant
		withAllProjectorsAndEventStore: eventStore)
		project: producedProjections
		ofTenant: aCommandOrEvent tenant.
	self logInfoMessage: 'Done'.
	^ producedProjections
]

{ #category : #accessing }
EDAHandler >> projectorClass [
	^ projectorClass ifNil: [ EDACompositeProjector ]
]

{ #category : #accessing }
EDAHandler >> projectorClass: anObject [
	projectorClass := anObject
]

{ #category : #handling }
EDAHandler >> retrieveAggregateRootClass: aCommand [
	^ aCommand aggregateRootClass
]
