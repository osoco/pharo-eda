"
Class:

I represent a projection: a different data structure created from event information, useful for performance reasons.

Responsibility:

I am in charge of projecting an event, and keeping my data structure correct. From the class side I also can check whether all persisted projections of my own class are synchronized, and can re-synchronize them if necessary.

Collaborators:

- I get notified whenever a new event is emitted, using the built-in Announcement mechanism.
- The EDAApplication instance calls me to ensure my projections are up to date.

Public API and Key Messages

- (class side) projectEvent: Project an event.
- (class side) projectEvents: Projects all recent events from a collection.
- You don't need to create instances, just use EDAProjection setupProjectionUsingEventStore: anEventStore

Internal Representation and Key Implementation Points.

The logic when an event is projected is:

- EDAProjection class>>projectEvent: anEvent
   -> EDAProjection class>>projectEvent: anEvent usingEmitingBlock: [ noop ]
We use this design to reuse the same process regardless of whether we are projecting a newly-emitted event, or we are rebuilding projections from events.  We want to emit new events (not to confuse with projectable events) using  Announcements mechanism. In the latter case, we want to add some additional information to the notifications we emit. The block expects an argument: the announcement instance. Take a look at EDAProjection class >> projectEvent:atIndex:ofTotalCount: to see other ways to call this method.
      -> EDAProjection class>>projectEvent: anEvent usingExistingBlock: aBlock
At this point we retrieve the concrete projection instance based on the event details. We do so using (EDAProjection subclass)>>retrieveProjectionForEvent: aEvent
Once we have the projection,  we look for methods tagged with #projectionForEvents: anEvent class in the current EDAProjection subclass.
For each one of those methods,
         -> EDAProjection delegateEventProjectionOf: anEvent in: aProjection to: projectionMethod andThen: aBlock
This method delegates the event to the annotated method. It's expected to return whether the event has been projected successfully or not. If it was successful, we increment the EDAProjection instance projected events count, and update the timestamp of the most recent projected event. Otherwise, we add the event to a list of unprocessed events.
Then, we save the projection, create the announcement, call the block to do whatever it needs to do with the announcement, and finishes.

Keep in mind that each EDAProjection subclass will include its own design when implementing the pragma-annotated methods.

    Instance Variables
	lastProjectedEvent:		The timestamp of the last projected event
	numProjectedEvents:		The number of projected events
	unprojectedEvents:		The list of unprojected events


    Implementation Points
"
Class {
	#name : #EDAProjection,
	#superclass : #Object,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#instVars : [
		'numProjectedEvents',
		'lastProjectedEvent',
		'unprojectedEvents',
		'lastModified',
		'createdAt'
	],
	#classInstVars : [
		'voyageRepository',
		'errorStrategy',
		'repository'
	],
	#category : 'EDA-Projections-Views'
}

{ #category : #persistence }
EDAProjection class >> findAllOfTenant: aTenant [
	^ self voyageRepository
		ifNil: [ OrderedCollection new ]
		ifNotNil: [ :r | r findAllProjections: self ofTenant: aTenant ]
]

{ #category : #accessing }
EDAProjection class >> projectionErrorHandlingStrategy [
	^ errorStrategy
]

{ #category : #accessing }
EDAProjection class >> projectionErrorHandlingStrategy: aStrategy [
	errorStrategy := aStrategy
]

{ #category : #persistence }
EDAProjection class >> removeAllProjections [
	(EDAProjection subclasses
		reject:
			[ :projectionClass | projectionClass class name beginsWith: 'EDATest' ])
		do:
			[ :aProjectionClass | self voyageRepository ifNotNil: [ :r | r removeProjection: aProjectionClass ] ]
]

{ #category : #persistence }
EDAProjection class >> removeAllProjectionsOfTenant: aTenant [
	(EDAProjection subclasses
		reject:
			[ :projectionClass | projectionClass class name beginsWith: 'EDATest' ])
		do: [ :aProjectionClass |
			self voyageRepository
				ifNotNil: [ :r | r removeProjection: aProjectionClass ofTenant: aTenant] ]
]

{ #category : #persistence }
EDAProjection class >> removeProjectionOfTenant: aTenant [
	self voyageRepository ifNotNil: [ :r | r removeProjection: self ofTenant: aTenant].
	EDAProjectionRemoved new
		projection: self;
		tenant: aTenant;
		emit
]

{ #category : #accessing }
EDAProjection class >> repository [
	^ repository
]

{ #category : #accessing }
EDAProjection class >> repository: aRepository [
	repository := aRepository
]

{ #category : #accessing }
EDAProjection >> addUnprojectedEvent: anEvent [
	"I'm not sure if this can lead to duplicate saves in Mongo. It's disabled until I figure it out.
	| collection |
	collection := self unprojectedEvents copy.
	collection add: anEvent.
	self unprojectedEvents: collection"
]

{ #category : #accessing }
EDAProjection >> createdAt [
	^ createdAt
]

{ #category : #accessing }
EDAProjection >> createdAt: aTimestamp [
	createdAt := aTimestamp
]

{ #category : #accessing }
EDAProjection >> incProjectedEvents [
	numProjectedEvents := self numProjectedEvents + 1.
]

{ #category : #initialization }
EDAProjection >> initialize [
	super initialize.
	self unprojectedEvents: OrderedCollection new.
	self createdAt: DateAndTime now.
	self lastModified: self createdAt
]

{ #category : #accessing }
EDAProjection >> lastModified [
	^ lastModified
]

{ #category : #accessing }
EDAProjection >> lastModified: aTimestamp [
	lastModified := aTimestamp
]

{ #category : #accessing }
EDAProjection >> lastProjectedEvent [
	lastProjectedEvent ifNil: [ lastProjectedEvent := Date new ].
	^ lastProjectedEvent
]

{ #category : #accessing }
EDAProjection >> modified [
	self lastModified: DateAndTime now
]

{ #category : #accessing }
EDAProjection >> numProjectedEvents [
	numProjectedEvents ifNil: [ numProjectedEvents := 0 ].
	^ numProjectedEvents
]

{ #category : #persistence }
EDAProjection >> removeProjectionOfTenant: aTenant [
	self class removeProjection: aTenant
]

{ #category : #persistence }
EDAProjection >> saveProjection [
	self class repository save: self
]

{ #category : #persistence }
EDAProjection >> selectOfTenant: aTenant manyWhere: aDictionary [
	^ self class repository selectOfTenant: aTenant many: self class where: aDictionary
]

{ #category : #persistence }
EDAProjection >> selectOfTenant: aTenant oneWhere: aDictionary [
	^ self class repository selectOfTenant: aTenant one: self class where: aDictionary
]

{ #category : #accessing }
EDAProjection >> unprojectedEvents [
	^ unprojectedEvents
]

{ #category : #accessing }
EDAProjection >> unprojectedEvents: aCollection [
	unprojectedEvents := aCollection
]

{ #category : #accessing }
EDAProjection >> updateLastProjectedEvent: timestamp [
	lastProjectedEvent := timestamp 
]
