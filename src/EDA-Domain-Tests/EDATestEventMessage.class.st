Class {
	#name : #EDATestEventMessage,
	#superclass : #EDATestMessage,
	#category : #'EDA-Domain-Tests'
}

{ #category : #'instance creation' }
EDATestEventMessage class >> checkValidClass: anEventClass [.
	(anEventClass == EDAEventSourcingEvent or: [ anEventClass inheritsFrom: EDAEventSourcingEvent ]) ifFalse: [ self logErrorMessage: (anEventClass name , ' is not an event class') andThrow: EDAInvalidClassToCreateTestMessage ].
]

{ #category : #helper }
EDATestEventMessage class >> domainToMessageAttributesMap [
	^ EDAJsonEventSerializer domainToMessageAttributesMap
]

{ #category : #helper }
EDATestEventMessage class >> generatedAttributesWhenPublishing [
"These attributes are generated when published. Only needed for events. Therefore they are not known by event objects"
	^ Set
		with: #messageId
		with: #type
]

{ #category : #helper }
EDATestEventMessage class >> nonDomainAttributesFor: aCommandOrEvent [
"these attributes do not correspond to the domain"
	| nonDomainAttributes |
	nonDomainAttributes := super nonDomainAttributesFor: aCommandOrEvent.
	nonDomainAttributes addAll: self generatedAttributesWhenPublishing. 
	^ nonDomainAttributes
]

{ #category : #accessing }
EDATestEventMessage >> domainAttributes [
	| domainAttributes |
	domainAttributes := super domainAttributes.
	"It is the event message id. It is generated when publishing the event."
	domainAttributes removeKey: #messageId ifAbsent: [].
	"It is the event type. It is generated from the class when publishing the event."
	domainAttributes removeKey: #type ifAbsent: [].
	^ domainAttributes
]

{ #category : #preconditions }
EDATestEventMessage >> instVarsNeededException [
	^ EDAEventInstVarsNeeded
]

{ #category : #'helper - inst var checking' }
EDATestEventMessage >> instVarsNeededMessage [
	^ [ :instvars :className | 'Check creation of instance variables: ' , instvars 
						, ' and accessors for class ' , className ]
]
