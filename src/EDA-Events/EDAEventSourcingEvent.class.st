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
	#traits : 'EDAPrintOnHelper + EDATHashHelper + EDATEqualsHelper + EDATLogging',
	#classTraits : 'EDAPrintOnHelper classTrait + EDATHashHelper classTrait + EDATEqualsHelper classTrait + EDATLogging classTrait',
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
	^ Set
		with: #timestamp
		"It is the id on meta message. Generated when publishing the event"
		with: #messageId
]

{ #category : #helpers }
EDAEventSourcingEvent class >> classPrefix [
	^ (self name regex: '^([A-Z]+)' matchesCollect: [ :each | each asString ]) first allButLast
]

{ #category : #helpers }
EDAEventSourcingEvent class >> formattedDate: aDateCreated [
	| currentFormattedDateAndTime |
	currentFormattedDateAndTime := DateAndTime now asUTC rounded.
	aDateCreated
		ifNil: [ ^ currentFormattedDateAndTime ]
		ifNotNil: [ :dc |
			dc isString
				ifTrue: [
					^ [ dc asDateAndTime asUTC rounded ]
						on: Error
						do: [ 
							self logErrorMessage: 'Current date used as dateCreated. Invalid dateCreated ' , dc greaseString.
							currentFormattedDateAndTime ] ].
			(dc isKindOf: DateAndTime) 
				ifTrue: [ ^ dc asUTC rounded ]
		]
]

{ #category : #meta }
EDAEventSourcingEvent class >> isEventGenerated: attr [
	^ self attributesWhoseValuesGetGenerated anySatisfy: [ :v | v = attr ]
]

{ #category : #accessing }
EDAEventSourcingEvent class >> latestVersion [
	<doc: 'Retrieves the latest version of the event class'>
	self subclassResponsibility
]

{ #category : #meta }
EDAEventSourcingEvent class >> nonPublishableBodyAttributes [
	"Override adding or removing attributes non publishable if its needed
	e.g.
	| nonPublishableBodyAttributes |
	nonPublishableBodyAttributes := super nonPublishableBodyAttributes.
	nonPublishableBodyAttributes
		addAll:
			(Set 
				with: #attributeNonpublishable1
				with: #attributeNonpublishable2
				with: #attributeNonpublishable3).
	nonPublishableBodyAttributes remove: #attributePublishable ifAbsent: [  ].
	^ nonPublishableBodyAttributes"
	^ Set
		with: #aggregateRootClass
		with: #delete 
		with: #agent
]

{ #category : #meta }
EDAEventSourcingEvent class >> ofTenant: theTenant withAggregateId: theId commandId: theCommandId andAttributes: theAttrs [
	| event timestamp previousAggregateRootVersion aggregateRootVersion |
	event := self new.
	event tenant: theTenant.
	event id: theId.
	event commandId: theCommandId.
	timestamp := theAttrs at: 'timestamp' 
		ifPresent: [ :ts | (DateAndTime fromString: ts) asUTC ]
		ifAbsent: [ DateAndTime now asUTC ].
	event timestamp: timestamp.
	previousAggregateRootVersion :=  theAttrs at: 'aggregateRootVersion' ifAbsent: [ nil ].
	aggregateRootVersion := previousAggregateRootVersion ifNil: [ 1 ] ifNotNil: [ :pARV | pARV + 1 ].
	event aggregateRootVersion: aggregateRootVersion.
	event version: self latestVersion.
	(self allInstVarNames reject: [ :var | #(#aggregateRootClass #aggregateRootVersion #commandId #delete #id #tenant #timestamp #version) includes: var ])
		do: [ :instVarName |
			| value |
			value := theAttrs at: instVarName ifAbsent: [ nil ].
			"do not set the new value if it is nil to avoid removing the initialized values"
			value ifNotNil: [ 
				event
					instVarNamed: instVarName asString
					put: value
					ifAbsent: [ 
						self logWarningMessage: 
							(String streamContents: [ :stream |
								stream nextPutAll:  'No such inst var ['.
								stream nextPutAll: instVarName greaseString.
								stream nextPutAll: '] to set in ['.
								stream nextPutAll: self name.
								stream nextPutAll: ']' ]) ]	] ].
	^ event
]

{ #category : #meta }
EDAEventSourcingEvent class >> old_ofTenant: theTenant withAggregateId: theId commandId: theCommandId andAttributes: theAttrs [
	| result scopeKey scopeContext previousAggregateRootVersion aggregateRootVersion |
	result := self new.
	result tenant: theTenant.
	result id: theId.
	result commandId: theCommandId.
	result
		timestamp: (theAttrs at: 'timestamp' ifAbsent: [ DateAndTime now asUTC ]).
	previousAggregateRootVersion :=  theAttrs at: 'aggregateRootVersion' ifAbsent: [ nil ].
	aggregateRootVersion := previousAggregateRootVersion ifNil: [ 1 ] ifNotNil: [ :pARV | pARV + 1 ].
	result aggregateRootVersion: aggregateRootVersion.
	result version: self latestVersion.
	scopeKey := theAttrs at: 'scopeKey' ifAbsent: [ nil ].
	scopeKey ifNotNil: [ :sk | result scopeKey: sk ].
	scopeContext := theAttrs at: 'scopeContext' ifAbsent: [ nil ].
	scopeContext ifNotNil: [ :s | result scopeContext: s ].
	theAttrs at: 'agent' ifPresent: [ :v | result agent: v ].
	"theAttrs at: 'dateCreated' ifPresent: [ :v | result dateCreated: v ]."
	^ result
]

{ #category : #meta }
EDAEventSourcingEvent class >> publishableMetaAttributes [
	^ Set
		with: #version
		with: #timestamp
		with: #commandId
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
EDAEventSourcingEvent >> delete [
	self flag: #TODO. "Find out why initialize doesn't get called for EDAEventSourcingEvents"
	^ delete ifNil: [ delete := false ]
"	delete ifNil: [ self initialize ].
	^ delete"
]

{ #category : #accessing }
EDAEventSourcingEvent >> delete: aFlag [
	delete := aFlag
]

{ #category : #'inspector extensions' }
EDAEventSourcingEvent >> gtDebuggerSUnitPrint [
	"I return a textual representation of the object that is used by the SUnit debugger to compare objects using a textual diff."
	| eventDict |
	eventDict := self asDictionary.
	eventDict at: '.Class' put: self className.
	^ eventDict gtDebuggerSUnitPrint
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
	^ version
]

{ #category : #accessing }
EDAEventSourcingEvent >> version: aNumber [
	version := aNumber
]
