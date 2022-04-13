Class {
	#name : #EDATestEventMessage,
	#superclass : #EDATestMessage,
	#classVars : [
		'publishingCustomizationBlock'
	],
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

{ #category : #'class initialization' }
EDATestEventMessage class >> initialize [
	publishingCustomizationBlock := [ :domainJsonDictionary | EDAJsonEventSerializer publishingCustomizationForEventDict: domainJsonDictionary ]
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
EDATestEventMessage class >> publishingCustomizationBlock [
	^ publishingCustomizationBlock
]

{ #category : #accessing }
EDATestEventMessage class >> publishingCustomizationBlock: aOneArgumentBlock [
	"Set if necessary when overriding EDAJsonEventSerializer class >> #publishingCustomizationForEventDict:"
	publishingCustomizationBlock := aOneArgumentBlock
]

{ #category : #helper }
EDATestEventMessage class >> publishingCustomizationForJsonDict: domainJsonDictionary [
	self publishingCustomizationBlock value: domainJsonDictionary
]

{ #category : #preconditions }
EDATestEventMessage >> checkInstVars [
	super checkInstVars.
	self instVarsPublishedUnnecessarily
		ifNotEmpty: [ :instvars | 
			self
				logErrorMessage:
					(self instVarsPublishedUnnecessarilyMessage
						value: instvars greaseString
						value: commandOrEventClass name)
				andThrow: EDAEventInstVarsPublishedUnnecessarily ].
	self instVarsNeededToPublishButNot
		ifNotEmpty: [ :instvars | 
			self
				logErrorMessage:
					(self instVarsNeededToPublishButNotMessage
						value: instvars greaseString
						value: commandOrEventClass name)
				andThrow: EDAEventInstVarsNeededToPublishButNot ]
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

{ #category : #'helper - inst var checking' }
EDATestEventMessage >> instVarsNeededToPublishButNot [
	^ self templateAttributes \ (self comandOrEventInstVars \ commandOrEventClass nonPublishableBodyAttributes)
]

{ #category : #'helper - inst var checking' }
EDATestEventMessage >> instVarsNeededToPublishButNotMessage [
	^ [ :instvars :className | className , ' instance variables: ' , instvars 
						, ' are not published and should be. Review #nonPublishableBodyAttributes methods and remove from them' ]
]

{ #category : #'helper - inst var checking' }
EDATestEventMessage >> instVarsPublishedUnnecessarily [
	| templateAttributes publishedAttributes |
	templateAttributes := self templateAttributes.
	publishedAttributes := self comandOrEventInstVars \ commandOrEventClass nonPublishableBodyAttributes.
	^ publishedAttributes \ templateAttributes.
]

{ #category : #'helper - inst var checking' }
EDATestEventMessage >> instVarsPublishedUnnecessarilyMessage [
	^ [ :instvars :className | className , ' instance variables: ' , instvars 
						, ' are published and are not in the example template. Review the template or add to #nonPublishableBodyAttributes' ]
]
