Trait {
	#name : #EDATBDDHelper,
	#traits : 'EDATLogging + EDATRegexHelper',
	#category : #'EDA-Domain-Tests'
}

{ #category : #assertions }
EDATBDDHelper >> assertEvent: actual equals: expected [
	^ self assertObject: actual equals: expected
]

{ #category : #helpers }
EDATBDDHelper >> assertEvents: resultingEvents matchExpected: expectedEvents [
	self assert: resultingEvents size equals: expectedEvents size.
	resultingEvents
		keysAndValuesDo: [ :i :actual | 
			| expected |
			expected := expectedEvents at: i.
			self discardDateCreated: expected.
			self discardAgent: expected.
			self discardTimestamp: expected.
			self discardId: expected.
			self assertEvent:  (resultingEvents at: i) equals: expected ]
]

{ #category : #asserting }
EDATBDDHelper >> assertMethod: aString existsIn: aClass [
	self assert: (aClass respondsTo: aString)
]

{ #category : #assertions }
EDATBDDHelper >> assertObject: actual equals: expected [
	| diff |
	diff := expected odDiff: actual.
	^ self
		assert: (diff isNil or: [ diff identical ])
		description: [ diff greaseString ]
]

{ #category : #helpers }
EDATBDDHelper >> assertProjections: actualProjections matchExpected: expectedProjections [
	| previouslyEnabled |
	previouslyEnabled := ODWildcards enabled.
	ODWildcards enable.
	self assert: actualProjections size equals: expectedProjections size.
	expectedProjections
		keysAndValuesDo: [ :i :expected | 
			| classMatches instanceMatches |
			self discardDateCreated: expected.
			self discardLastModified: expected.
			self discardCreatedAt: expected.
			classMatches := actualProjections
				select: [ :actual | actual class = expected class ].
			self
				assert: classMatches isNotEmpty
				description: 'No projections created of class ' , expected class greaseString , '.'.
			instanceMatches := actualProjections
				select: [ :actual | self is: expected equalTo: actual ].
			instanceMatches
				ifEmpty: [ | actual |
					actual := classMatches any.
					self assertObject: expected equals: actual ] ].
			previouslyEnabled ifTrue: [ ODWildcards enable ] ifFalse: [ ODWildcards disable ]
]

{ #category : #helpers }
EDATBDDHelper >> buildCommandConsumerWithEventStore: anEventStore [
	| mock |
	mock := EDAAcceptEverything new.
	^ EDAMessageConsumer
		busListener: mock
		materializer: EDACommandMaterializer new
		dispatcher:
			(EDAApplication
				buildCommandDispatcherWithEventStore: anEventStore
				eventProducer: mock
				andProjectorClass: mock)
		strategy: EDAThrowError greaseString
]

{ #category : #helpers }
EDATBDDHelper >> buildCommandSerializer [
	^ EDAJsonCommandSerializer new
]

{ #category : #helpers }
EDATBDDHelper >> buildEventConsumerWithEventStore: anEventStore [
	| mock |
	mock := EDAAcceptEverything new.
	^ EDAMessageConsumer
		busListener: mock
		materializer: EDAEventMaterializer new
		dispatcher:
			(EDAApplication
				buildEventDispatcherWithEventStore: anEventStore
				eventProducer: mock
				andProjectorClass: mock)
]

{ #category : #helpers }
EDATBDDHelper >> buildEventSerializer [
	^ EDAJsonEventSerializer new
]

{ #category : #helpers }
EDATBDDHelper >> consumeMessage: aMessage using: aCommandConsumer [
	^ aCommandConsumer
		consumeMessage: aMessage
		usingStrategy: EDAThrowError greaseString
]

{ #category : #helpers }
EDATBDDHelper >> discard: selector on: anEventOrProjection [
	(anEventOrProjection respondsTo: selector)
		ifTrue: [ | class method |
			anEventOrProjection
				class classAndMethodFor: selector
				do: [ :c :m | 
					class := c.
					method := m ]
				ifAbsent: [ false ].
			anEventOrProjection
				perform: method selector
				withArguments: (OrderedCollection with: '<ANYTHING>')
				inSuperclass: class ]
]

{ #category : #helpers }
EDATBDDHelper >> discardAgent: anEvent [
	^ self if: anEvent supports: #agent: then: [ anEvent agent: '<ANYTHING>' ]
]

{ #category : #helpers }
EDATBDDHelper >> discardCreatedAt: anEventOrProjection [
	^ self
		if: anEventOrProjection
		supports: #createdAt:
		then: [ anEventOrProjection createdAt: '<ANYTHING>' ]
]

{ #category : #helpers }
EDATBDDHelper >> discardDateCreated: anEventOrProjection [
	^ self
		if: anEventOrProjection
		supports: #dateCreated:
		then: [ anEventOrProjection dateCreated: '<ANYTHING>' ]
]

{ #category : #helpers }
EDATBDDHelper >> discardLastModified: anEventOrProjection [
	^ self
		if: anEventOrProjection
		supports: #lastModified:
		then: [ anEventOrProjection lastModified: '<ANYTHING>' ]
]

{ #category : #helpers }
EDATBDDHelper >> discardTimestamp: anEventOrProjection [
	^ self
		if: anEventOrProjection
		supports: #timestamp:
		then: [ anEventOrProjection timestamp: '<ANYTHING>' ]
]

{ #category : #helpers }
EDATBDDHelper >> filterPastEvents: events ofAggregate: anAggregateRootSymbol [
	^ events
		select:
			[ :e | e aggregateRootClass greaseString asSymbol = anAggregateRootSymbol ]
]

{ #category : #BDD }
EDATBDDHelper >> givenEvents: pastEvents processingThem: aProcessingPastEventsBlock whenReceiveMessage: aString processingIt: aMessageBlock then: assertBlock [
	| commandConsumer resultingEvents eventStore eventsToSave originalEventStores aMessage |
	eventStore := EDAVolatileEventStore new.
	originalEventStores := self retrieveEventStores.
	[ self useEventStore: eventStore.
	eventsToSave := aProcessingPastEventsBlock
		value: pastEvents
		value: eventStore.
	eventStore saveEvents: eventsToSave.
	commandConsumer := self
		buildCommandConsumerWithEventStore: eventStore.
	aMessage := aMessageBlock value: eventsToSave value: aString.
	resultingEvents := self
		consumeMessage: aMessage
		using: commandConsumer.
	assertBlock value: resultingEvents value: eventStore ]
		ensure: [ self restoreEventStores: originalEventStores ]
]

{ #category : #BDD }
EDATBDDHelper >> givenEvents: pastEvents processingThem: aProcessingPastEventsBlock whenReceiveMessage: aString processingIt: aMessageBlock thenEvents: expectedResultingEvents processingThem: aProcessingExpectedEventsBlock [
	^ self
		givenEvents: pastEvents
		processingThem: aProcessingPastEventsBlock
		whenReceiveMessage: aString
		processingIt: aMessageBlock
		then: [ :actualEvents :eventStore | 
			| expected |
			expected := aProcessingExpectedEventsBlock
				value: expectedResultingEvents
				value: eventStore.
			self assertEvents: actualEvents matchExpected: expected ]
]

{ #category : #helpers }
EDATBDDHelper >> if: anObject supports: aSelector then: aBlock [
	(anObject respondsTo: aSelector)
		ifTrue: [ aBlock value ]
]

{ #category : #assertions }
EDATBDDHelper >> is: actual equalTo: expected [
	| diff |
	diff := expected odDiff: actual.
	^ diff isNil or: [ diff identical ]

]

{ #category : #helpers }
EDATBDDHelper >> restoreEventStores: aDictionary [
	EDAAggregateRepository
		allSubclassesDo: [ :c | c setupEventStore: (aDictionary at: c greaseString asSymbol) ]
]

{ #category : #helpers }
EDATBDDHelper >> retrieveEventStores [
	| result |
	result := Dictionary new.
	EDAAggregateRepository
		allSubclassesDo: [ :c | result at: c greaseString asSymbol put: c eventStore ].
	^ result
]

{ #category : #helpers }
EDATBDDHelper >> serializeCommand: aCommand [
	^ self buildCommandSerializer serialize: aCommand
]

{ #category : #helpers }
EDATBDDHelper >> serializeEvent: anEvent [
	^ self buildEventSerializer serialize: anEvent
]

{ #category : #helpers }
EDATBDDHelper >> useEventStore: anEventStore [
	EDAAggregateRepository
		allSubclassesDo: [ :c | c setupEventStore: anEventStore ]
]

{ #category : #BDD }
EDATBDDHelper >> whenReceiveCommand: aCommand ofType: aString then: aBlockClosure [
	^ self
		givenEvents: OrderedCollection empty
		processingThem: [ :pastEvents :eventStore | pastEvents ]
		whenReceiveMessage: aCommand
		processingIt: [ :events :str | str ]
		then: [ aBlockClosure value ]
]
