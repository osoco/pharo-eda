"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	aggregateRootClass:		<Object>
	aggregateRootVersion:		<Object>
	id:		<Object>
	timestamp:		<Object>


    Implementation Points
"
Class {
	#name : #EDAEventSourcingEvent,
	#superclass : #Announcement,
	#traits : 'EDAPrintOnHelper',
	#classTraits : 'EDAPrintOnHelper classTrait',
	#instVars : [
		'id',
		'timestamp',
		'aggregateRootVersion',
		'version',
		'delete',
		'aggregateRootClass',
		'tenant',
		'scopeContext',
		'scopeKey',
		'agent'
	],
	#classInstVars : [
		'voyageRepository',
		'latestVersion'
	],
	#category : #'EDA-Events-Events'
}

{ #category : #meta }
EDAEventSourcingEvent class >> aggregateRootClass [
	self subclassResponsibility 
]

{ #category : #meta }
EDAEventSourcingEvent class >> attributesWhoseValuesGetGenerated [
	^ #('id' 'timestamp') asSet
]

{ #category : #meta }
EDAEventSourcingEvent class >> isEventGenerated: attr [
	^ self attributesWhoseValuesGetGenerated anySatisfy: [ :v | v = attr ]
]

{ #category : #testing }
EDAEventSourcingEvent class >> isEventSourcingEvent [
	^ true
]

{ #category : #accessing }
EDAEventSourcingEvent class >> latestVersion [
	<doc: 'Retrieves the latest version of the event class'>
	self subclassResponsibility
]

{ #category : #meta }
EDAEventSourcingEvent class >> ofTenant: theTenant withAggregateId: theId commandId: theCommandId andAttributes: theAttrs [
	| result scopeKey scopeContext aggregateRootVersion |
	result := self new.
	result tenant: theTenant.
	result id: theId.
	result commandId: theCommandId.
	result
		timestamp: (theAttrs at: 'timestamp' ifAbsent: [ DateAndTime now asUTC ]).
	aggregateRootVersion :=  theAttrs at: 'aggregateRootVersion' ifPresent: [ :arv | arv + 1 ] ifAbsent: [ 1 ].
	result aggregateRootVersion: aggregateRootVersion.
	result version: self latestVersion.
	scopeKey := theAttrs at: 'scopeKey' ifAbsent: [ nil ].
	scopeKey ifNotNil: [ :sk | result scopeKey: sk ].
	scopeContext := theAttrs at: 'scopeContext' ifAbsent: [ nil ].
	scopeContext ifNotNil: [ :s | result scopeContext: s ].
	theAttrs at: 'agent' ifPresent: [ :v | result agent: v ].
	"theAttrs at: 'dateCreated' ifPresent: [ :v | result dateCreated: v ]."
	theAttrs at: 'entityId' ifPresent: [ :v | result entityId: v ].
	^ result
]

{ #category : #accessing }
EDAEventSourcingEvent >> agent [
	^ agent
]

{ #category : #accessing }
EDAEventSourcingEvent >> agent: aString [
	agent := aString
]

{ #category : #accessing }
EDAEventSourcingEvent >> aggregateRootClass [
	^ self class aggregateRootClass
]

{ #category : #accessing }
EDAEventSourcingEvent >> aggregateRootVersion [
	| result |
	result := aggregateRootVersion.
	result
		ifNil: [ result := 0.
			self aggregateRootVersion: result ].
	^ result
]

{ #category : #accessing }
EDAEventSourcingEvent >> aggregateRootVersion: anObject [
	aggregateRootVersion := anObject
]

{ #category : #accessing }
EDAEventSourcingEvent >> correlationId [
	^ ''
]

{ #category : #accessing }
EDAEventSourcingEvent >> delete [
	self flag: #TODO. "Find out why initialize doesn't get called for EDAEventSourcingEvents"
	delete ifNil: [ self initialize ].
	^ delete
]

{ #category : #accessing }
EDAEventSourcingEvent >> delete: aFlag [
	delete := aFlag
]

{ #category : #accessing }
EDAEventSourcingEvent >> id [
	^ id
]

{ #category : #accessing }
EDAEventSourcingEvent >> id: anObject [
	id := anObject
]

{ #category : #initialization }
EDAEventSourcingEvent >> initialize [
	super initialize.
	self delete: false.
	self timestamp ifNil: [ self timestamp: DateAndTime now asUTC ].
	aggregateRootClass := self aggregateRootClass greaseString
]

{ #category : #testing }
EDAEventSourcingEvent >> isEventSourcingEvent [
	^ self class isEventSourcingEvent
]

{ #category : #accessing }
EDAEventSourcingEvent >> routingKey [
	^ EDASourceCodeHelperStub new
		camelCaseToDotSeparated: (EDAMessageSerializer nameWithoutPrefixForMessageClass: self class)
]

{ #category : #accessing }
EDAEventSourcingEvent >> scopeContext [
	^ scopeContext
]

{ #category : #accessing }
EDAEventSourcingEvent >> scopeContext: aDictionary [
	scopeContext := aDictionary
]

{ #category : #accessing }
EDAEventSourcingEvent >> scopeKey [
	^ scopeKey
]

{ #category : #accessing }
EDAEventSourcingEvent >> scopeKey: anOrderedCollection [
	scopeKey := anOrderedCollection
]

{ #category : #accessing }
EDAEventSourcingEvent >> tenant [
	^ tenant
]

{ #category : #accessing }
EDAEventSourcingEvent >> tenant: aString [
	tenant := aString
]

{ #category : #accessing }
EDAEventSourcingEvent >> timestamp [
	^ timestamp
]

{ #category : #accessing }
EDAEventSourcingEvent >> timestamp: anObject [
	timestamp := anObject
]

{ #category : #accessing }
EDAEventSourcingEvent >> uniqueId [
	^ self id
]

{ #category : #accessing }
EDAEventSourcingEvent >> version [
	| result |
	result := version.
	result
		ifNil: [ result := 1.
			self version: result ].
	^ result
]

{ #category : #accessing }
EDAEventSourcingEvent >> version: aNumber [
	version := aNumber
]
