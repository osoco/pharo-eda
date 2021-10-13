Class {
	#name : #EDAProjector,
	#superclass : #Object,
	#traits : 'EDATCollectionHelper + EDATLogging',
	#classTraits : 'EDATCollectionHelper classTrait + EDATLogging classTrait',
	#instVars : [
		'eventStore',
		'tenant'
	],
	#classVars : [
		'HeadlessMode'
	],
	#classInstVars : [
		'errorStrategy',
		'synchronizationInProgressByTenant'
	],
	#category : #'EDA-Projections-Projectors'
}

{ #category : #'class initialization' }
EDAProjector class >> doInitialize [
	synchronizationInProgressByTenant := Dictionary new
]

{ #category : #accessing }
EDAProjector class >> errorHandlingBehavior [
	self subclassResponsibility
]

{ #category : #accessing }
EDAProjector class >> headlessMode [
	^ HeadlessMode 
]

{ #category : #accessing }
EDAProjector class >> headlessMode: aBoolean [
	HeadlessMode := aBoolean
]

{ #category : #'class initialization' }
EDAProjector class >> initialize [
	self doInitialize
]

{ #category : #design }
EDAProjector class >> isAbstract [
	^ true
]

{ #category : #accessing }
EDAProjector class >> isEnabled [
	^ true
]

{ #category : #'instance creation' }
EDAProjector class >> ofTenant: aTenant withEventStore: anEventStore [
	^ self new
		tenant: aTenant;
		eventStore: anEventStore;
		yourself
]

{ #category : #ordering }
EDAProjector class >> order [
	self subclassResponsibility
]

{ #category : #'projection retrieval' }
EDAProjector class >> projectEvents: aCollectionOfEvents [
	self projectEvents: aCollectionOfEvents to: self projectionClass
]

{ #category : #'projection retrieval' }
EDAProjector class >> projectEvents: aCollectionOfEvents to: aProjectionClass [
	aCollectionOfEvents do: [ :anEvent | aProjectionClass projectEvent: anEvent ]
]

{ #category : #'projection retrieval' }
EDAProjector class >> projectionClass [
	self subclassResponsibility 
]

{ #category : #accessing }
EDAProjector class >> synchronizationInProgressOfTenant: aTenant [
	^ synchronizationInProgressByTenant at: aTenant ifAbsent: [ false ]
]

{ #category : #accessing }
EDAProjector class >> synchronizationInProgressOfTenant: aTenant is: aBoolean [
	synchronizationInProgressByTenant at: aTenant put: aBoolean
]

{ #category : #'projection creation' }
EDAProjector >> createNewProjectionForEvent: anEvent [
	self subclassResponsibility 
]

{ #category : #projecting }
EDAProjector >> delegateEventProjectionOf: anEvent in: aProjection to: aProjectionMethod andThen: aBlock [
	self subclassResponsibility
]

{ #category : #accessing }
EDAProjector >> eventStore [
	^ eventStore
]

{ #category : #accessing }
EDAProjector >> eventStore: anEventStore [
	eventStore := anEventStore
]

{ #category : #'event filtering' }
EDAProjector >> filterEventsToProject: anEventCollection accordingToTimestamp: aTimestamp [
	^ (anEventCollection select: [ :each | each timestamp > aTimestamp ]) asSortedCollection: [ :i :j | i timestamp < j timestamp ]
]

{ #category : #checks }
EDAProjector >> isSynchronized: projectionSourceEvents ofTenant: aTenant [
	| isSynchronized totalProjectedEventsSize |
	self
		logDebugMessage:
			'Checking if ' , self class projectionClass name greaseString
				, ' requires synchronization.'.
	totalProjectedEventsSize := self totalProjectedEventsOfTenant: aTenant.
	isSynchronized := projectionSourceEvents size
		<= totalProjectedEventsSize.
	EDAProjectionSynchronizationChecked new
		projection: self;
		synchronized: isSynchronized;
		projectionSourceEventsSize: projectionSourceEvents size;
		totalProjectedEventsSize: totalProjectedEventsSize;
		emit.
	isSynchronized
		ifTrue: [ self
				logDebugMessage:
					self class projectionClass name greaseString
						, ' already synchronized.' ]
		ifFalse: [ self
				logDebugMessage:
					self class projectionClass name greaseString
						, ' needs synchronization ('
						, totalProjectedEventsSize greaseString , '/'
						, projectionSourceEvents size greaseString , ').' ].
	^ isSynchronized
]

{ #category : #logging }
EDAProjector >> logEvent: eventId ofTenant: aTenant ofEventClass: eventClass atPosition: index ofTotal: total projectedIn: projectionClass [
	self
		logInfoMessage:
			'[' , aTenant greaseString , ':' , index greaseString , '/' , total greaseString , '] '
				, projectionClass greaseString , ' <- ' , eventClass greaseString
				, ' (' , eventId greaseString , ')'
]

{ #category : #removing }
EDAProjector >> minimumEventsToProjectFrom: anEventCollection [
"Customize on subclasses"
	^ anEventCollection 
]

{ #category : #projecting }
EDAProjector >> projectEvent: anEvent [
	^ self projectEvent: anEvent usingEmittingBlock: [ :eventToEmit |  ]
]

{ #category : #projecting }
EDAProjector >> projectEvent: anEvent atIndex: anIndex ofTotalCount: aCount [
	^ self
		projectEvent: anEvent
		usingEmittingBlock: [ :eventToEmit |
			eventToEmit
				index: anIndex;
				projectionSourceEventsSize: aCount ]
]

{ #category : #projecting }
EDAProjector >> projectEvent: anEvent usingEmittingBlock: aBlock [
	self subclassResponsibility
]

{ #category : #'projection retrieval' }
EDAProjector >> projectEvents: anEventCollection ofTenant: aTenant [
	self flag: #TODO.
	"Re-Introducir comprobar si está sincronizada la proyección"
	anEventCollection
		ifNotEmpty: [ self synchronizeEvents: anEventCollection ofTenant: aTenant ]
"	anEventCollection
		ifNotEmpty: [ (self isSynchronized: anEventCollection ofTenant: aTenant)
				ifFalse: [ self synchronizeEvents: anEventCollection ofTenant: aTenant] ]"
]

{ #category : #'projection retrieval' }
EDAProjector >> projectEvents: anEventCollection ofTenant: aTenant usingErrorStrategy: anErrorStrategy [
	(self isSynchronized: anEventCollection ofTenant: aTenant)
		ifFalse: [ self synchronizeEvents: anEventCollection ofTenant: aTenant]
]

{ #category : #projecting }
EDAProjector >> projectFilteredEvents: anEventCollection ofTenant: aTenant [
	anEventCollection isEmpty
		ifTrue: [ self
				logInfoMessage:
					'No events to project to '
						, self class projectionClass name greaseString , '.' ]
		ifFalse: [ self
				logInfoMessage:
					'Begin projecting ' , anEventCollection size greaseString
						, ' events in ' , self class projectionClass name greaseString
						, '.'.
			self
				projectFilteredEvents: anEventCollection ofTenant: aTenant
				usingBlock: [ :projection :event :index |  ].
			self
				logInfoMessage:
					'End projecting ' , anEventCollection size greaseString
						, ' events in ' , self class projectionClass name greaseString
						, '.' ]
]

{ #category : #projecting }
EDAProjector >> projectFilteredEvents: anEventCollection ofTenant: aTenant usingBlock: aBlock [
	self subclassResponsibility
]

{ #category : #api }
EDAProjector >> projectOfTenant: aTenant [
	| projectionSourceEvents minimumEventsToProject |
	(self class synchronizationInProgressOfTenant: aTenant)
		ifTrue: [ ^ self ].
	self class synchronizationInProgressOfTenant: aTenant is: true.
	self
		logDebugMessage:
			'Projection request for ' , self class projectionClass greaseString
				, ' in tenant ' , aTenant , '.'.
	projectionSourceEvents := self sourceEventsOfTenant: aTenant.
	minimumEventsToProject := self minimumEventsToProjectFrom: projectionSourceEvents.
	self projectEvents: minimumEventsToProject ofTenant: aTenant.
	self
		logDebugMessage:
			'End of projection request ' , self class projectionClass greaseString
				, ' in tenant ' , aTenant , '.'.
	self class synchronizationInProgressOfTenant: aTenant is: false
]

{ #category : #removing }
EDAProjector >> removeDuplicatesBlock [
	^ [ :first :second | first class = second class and: [ first id = second id ] ]
]

{ #category : #'projection retrieval' }
EDAProjector >> retrieveAllProjectionsOfTenant: aTenant [
	^ self class projectionClass findAllOfTenant: aTenant
]

{ #category : #'projection retrieval' }
EDAProjector >> retrieveLastProjectedEventTimestampFromProjections: aProjectionCollection [
	| result |
	aProjectionCollection ifEmpty: [ result := Date new ] ifNotEmpty: [ result := (aProjectionCollection collect: [ :each | each lastProjectedEvent ]) asSortedCollection last ].
	^ result
]

{ #category : #'projection retrieval' }
EDAProjector >> retrieveLastProjectedEventTimestampOfTenant: aTenant [
	| currentProjections result |
	currentProjections := self retrieveAllProjectionsOfTenant: aTenant.
	result := self
		retrieveLastProjectedEventTimestampFromProjections: currentProjections.
	^ result
]

{ #category : #helper }
EDAProjector >> retrieveProjectionHandlerMethodsForEvent: anEvent [
	| result projectionHandlers |
	projectionHandlers := Pragma allNamed: #projectionForEvents: in: self class.
	result := projectionHandlers
		select: [ :pragma | pragma arguments first anySatisfy: [ :supportedEvent | supportedEvent = anEvent class name ] ]
		thenCollect: [ :pragma | pragma method ].
	^ result
]

{ #category : #'event retrieval' }
EDAProjector >> sourceEvents: anEventStore ofTenant: aTenant [
	| eventTypes |
	eventTypes := ((Pragma
		allNamed: 'projectionForEvents:'
		in: self class) collect: [ :p | p arguments first ]) flattened.
	self flag: #TODO.
	"Rehacer filtrado de innecesarios"
	"result := self
		removeDuplicatesIn: aux
		matching: self removeDuplicatesBlock."
	^ (eventTypes
		flatCollect: [ :t | 
			anEventStore
				findEventsOfTenant: aTenant
				ofType: (self class environment at: t) ]
		as: OrderedCollection)
		sort: [ :event1 :event2 | event1 timestamp < event2 timestamp ]
]

{ #category : #'event retrieval' }
EDAProjector >> sourceEventsOfTenant: aTenant [
	^ self sourceEvents: self eventStore ofTenant: aTenant
]

{ #category : #'event synchronization' }
EDAProjector >> synchronizeEvents: anEventCollection ofTenant: aTenant [
	"self synchronizeEventsBasedOnLastProjectedEventTimestamp: anEventCollection"

	self projectFilteredEvents: anEventCollection ofTenant: aTenant
]

{ #category : #'event synchronization' }
EDAProjector >> synchronizeEventsBasedOnLastProjectedEventTimestamp: anEventCollection ofTenant: aTenant [
	| timestamp filteredEvents |
	timestamp := self
		retrieveLastProjectedEventTimestampOfTenant: aTenant.
	filteredEvents := self
		filterEventsToProject: anEventCollection
		accordingToTimestamp: timestamp.
	self projectFilteredEvents: filteredEvents ofTenant: aTenant
]

{ #category : #accessing }
EDAProjector >> tenant [
	^ tenant
]

{ #category : #accessing }
EDAProjector >> tenant: aTenant [
	tenant := aTenant
]

{ #category : #'event retrieval' }
EDAProjector >> totalProjectedEventsOfTenant: aTenant [
	| allProjectionsOfThisKind totalProjectedEvents |
	allProjectionsOfThisKind := self
		retrieveAllProjectionsOfTenant: aTenant.
	totalProjectedEvents := allProjectionsOfThisKind
		ifNil: [ 0 ]
		ifNotNil: [ :prjs |
			prjs isEmpty
				ifTrue: [ 0 ]
				ifFalse: [ allProjectionsOfThisKind size = 1
						ifTrue: [ allProjectionsOfThisKind first numProjectedEvents ]
						ifFalse: [ (allProjectionsOfThisKind
								collect: [ :proj | proj numProjectedEvents ])
								reduce: [ :a :b | a + b ] ] ] ].
	^ totalProjectedEvents
]
