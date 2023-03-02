Class {
	#name : #EDASingleProjectionPerEventProjector,
	#superclass : #EDAProjector,
	#traits : 'EDATErrorHelper',
	#classTraits : 'EDATErrorHelper classTrait',
	#category : #'EDA-Projections-Projectors'
}

{ #category : #projecting }
EDASingleProjectionPerEventProjector >> delegateEventProjectionOf: anEvent in: aProjection to: aProjectionMethod [
	| result |
	result := self perform: aProjectionMethod selector with: anEvent with: aProjection.
	^ result
]

{ #category : #projecting }
EDASingleProjectionPerEventProjector >> delegateEventProjectionOf: anEvent in: aProjection to: aProjectionMethod andThen: aBlock [
	| succeed |
	[ | eventToEmitClass eventToEmit |
	succeed := self
		delegateEventProjectionOf: anEvent
		in: aProjection
		to: aProjectionMethod.
	succeed
		ifTrue: [ aProjection updateLastProjectedEvent: anEvent timestamp ]
		ifFalse: [ aProjection addUnprojectedEvent: anEvent ].
	aProjection saveProjection.
	eventToEmitClass := succeed
		ifTrue: [ EDAEventProjected ]
		ifFalse: [ EDAEventNotProjected ].
	eventToEmit := eventToEmitClass new
		projection: aProjection class;
		event: anEvent.
	aBlock value: eventToEmit.
	eventToEmit emit ]
		on: Exception
		do: [ :exception | 
			succeed := self
				manageError: exception
				whenProjectingEvent: anEvent
				usingErrorStrategy: self class errorHandlingBehavior strategy ].
	^ succeed
]

{ #category : #projecting }
EDASingleProjectionPerEventProjector >> iteratingBlock [
	^ [ :index :event :projection |  ]
]

{ #category : #handling }
EDASingleProjectionPerEventProjector >> notifyError: anException withTitle: errorTitle andProcessingMessage: aMessage andFuelContext: fuelContextFileReference [
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

{ #category : #projecting }
EDASingleProjectionPerEventProjector >> projectEvent: anEvent usingEmittingBlock: aBlock [
	| projectionHandlers result |
	projectionHandlers := self retrieveProjectionHandlerMethodsForEvent: anEvent.
	projectionHandlers
		ifEmpty: [ self
				logDebugMessage:
					'Event ' , anEvent class greaseString , '(' , anEvent id greaseString , ') cannot be projected since projector ' , self class greaseString
						, ' doesn''t support it.'.
				^ nil ].
	projectionHandlers size > 1
		ifTrue: [ self
				logErrorMessage:
					'Event ' , anEvent class greaseString , '(' , anEvent id greaseString , ') will be projected twice in projection '
						, self class projectionClass greaseString , '.' ].
	projectionHandlers
		ifNotEmpty: [ :handlerCollection | 
			result := self retrieveProjectionForEvent: anEvent.
			result := result ifNil: [ self createNewProjectionForEvent: anEvent ] ].
	result
		ifNotNil: [ :projection | 
			projectionHandlers
				do: [ :projectionMethod | 
					self
						delegateEventProjectionOf: anEvent
						in: projection
						to: projectionMethod
						andThen: aBlock ] ].
	^ result
]

{ #category : #projecting }
EDASingleProjectionPerEventProjector >> projectFilteredEvents: anEventCollection ofTenant: aTenant usingBlock: aBlock [
	^ self
		projectFilteredEvents: anEventCollection
		ofTenant: aTenant
		usingBlock: aBlock
		betweenEvents: self iteratingBlock
]

{ #category : #projecting }
EDASingleProjectionPerEventProjector >> projectFilteredEvents: anEventCollection ofTenant: aTenant usingBlock: aBlock betweenEvents: iterationBlock [
	| projectionLogic |
	projectionLogic := [ :index :event |
	| aProjection |
	self
		logEvent: event id
		ofTenant: aTenant
		ofEventClass: event class
		atPosition: index
		ofTotal: anEventCollection size
		projectedIn: self class projectionClass.
	aProjection := self
		projectEvent: event
		atIndex: index
		ofTotalCount: anEventCollection size.
	aBlock value: aProjection value: event value: index.
	iterationBlock value: index value: event value: aProjection ].
	self class headlessMode
		ifTrue: [ anEventCollection keysAndValuesDo: projectionLogic ]
		ifFalse: [ anEventCollection
				keysAndValuesDo: projectionLogic
				displayingProgress: [ :index :event |
					'Processing event ' , index greaseString , '/'
						, anEventCollection size greaseString , ' : '
						, event class greaseString , ' (' , event id greaseString , ')' ] ]
]

{ #category : #'projection retrieval' }
EDASingleProjectionPerEventProjector >> retrieveProjectionForEvent: anEvent [
	self subclassResponsibility
]
