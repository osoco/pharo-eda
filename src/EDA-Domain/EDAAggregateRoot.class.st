Class {
	#name : #EDAAggregateRoot,
	#superclass : #Object,
	#traits : 'EDATLogging + EDATHashHelper + EDATEqualsHelper',
	#classTraits : 'EDATLogging classTrait + EDATHashHelper classTrait + EDATEqualsHelper classTrait',
	#instVars : [
		'id',
		'version',
		'isDeleted',
		'scopeContext',
		'scopeKey',
		'brandNew',
		'tenant'
	],
	#category : #'EDA-Domain-Aggregate'
}

{ #category : #accessing }
EDAAggregateRoot class >> aggregateRepository [
	self subclassResponsibility
]

{ #category : #helpers }
EDAAggregateRoot class >> buildCommonArgsForCommand: aCommand [
	| result |
	result := Dictionary new.
	result at: 'tenant' put: aCommand tenant.
	result at: 'version' put: aCommand version.
	result at: 'aggregateRootVersion' put: aCommand aggregateRootVersion.
	result at: 'aggregateRootClass' put: self class.
	aCommand scopeKey ifNotNil: [ :key | result at: 'scopeKey' put: key ].
	aCommand scopeContext
		ifNotNil: [ :ctx | result at: 'scopeContext' put: ctx ].
	^ result
]

{ #category : #helpers }
EDAAggregateRoot class >> changeCommonArgsForCommandAttributes: aCommandAttributes [
	aCommandAttributes at: 'aggregateRootClass' put: self greaseString
]

{ #category : #helpers }
EDAAggregateRoot class >> checkTenantIsValid: tenantOfCommand [
	tenantOfCommand isNotNil
		ifFalse:
			[ self logErrorMessage: 'tenant is missing' andThrow: InvalidTenant ]
]

{ #category : #helpers }
EDAAggregateRoot class >> classPrefix [
	^ (self name regex: '^([A-Z]+)' matchesCollect: [ :each | each asString ]) first allButLast
]

{ #category : #helpers }
EDAAggregateRoot class >> newVersionAfter: aVersion [
	^ aVersion + 1
]

{ #category : #ui }
EDAAggregateRoot class >> systemIcon [
	^ Smalltalk ui icons iconNamed: #objects
]

{ #category : #'applying events' }
EDAAggregateRoot >> applyAggregateDeletedEvent: anEvent [
	self isDeleted: true
]

{ #category : #'applying events' }
EDAAggregateRoot >> applyEvent: anEvent [
	| eventClassName applyEventSelector applyEventSelectorSymbol delete |
	delete := anEvent delete.
	delete
		ifNil: [ self
				logWarningMessage:
					((WriteStream on: String new)
						nextPutAll: anEvent class greaseString;
						nextPutAll:
							' implements an invalid #initialize method. Make sure it calls parent''s initialize.';
						close;
						contents).
			delete := false ].
	delete
		ifTrue: [ self applyAggregateDeletedEvent: anEvent ]
		ifFalse: [ eventClassName := anEvent class greaseString.
			applyEventSelector := self
				retrieveApplyEventMethod: anEvent
				withLogging: false.
			applyEventSelector
				ifNotNil: [ :arg | 
					| text max last suffix |
					max := 50.
					suffix := ''.
					text := anEvent greaseString.
					text size > max
						ifTrue: [ last := max.
							suffix := '...' ]
						ifFalse: [ last := text size ].
					applyEventSelectorSymbol := applyEventSelector asSymbol.
					self
						logTraceMessage:
							((WriteStream on: String new)
								nextPutAll: self class greaseString;
								nextPut: $(;
								nextPutAll: self id greaseString;
								nextPutAll: ')>>';
								nextPutAll: applyEventSelectorSymbol greaseString;
								nextPutAll: ' ''';
								nextPutAll: (text copyFrom: 1 to: last) greaseString;
								nextPutAll: suffix greaseString;
								close;
								contents).
					self perform: applyEventSelectorSymbol with: anEvent.
					self id: anEvent id.
					self brandNew: false.
					self version: (self version + 1) ]
				ifNil: [ anEvent class greaseString = self class greaseString
						ifTrue: [ self
								logErrorMessage:
									((WriteStream on: String new)
										nextPutAll: 'Aggregate root class mismatch for ';
										nextPutAll: anEvent class greaseString;
										nextPutAll: ' event : ';
										nextPutAll: anEvent greaseString;
										nextPutAll: '. It''s ';
										nextPutAll: self class greaseString;
										nextPutAll: ' but should be ';
										nextPutAll: anEvent aggregateRootClass greaseString;
										close;
										contents) ].
					self logDebugMessage: 'No apply method for ' , anEvent class greaseString , ' version ' , anEvent class latestVersion greaseString ] ]
]

{ #category : #'applying events' }
EDAAggregateRoot >> applyEvents: eventsCollection [
	eventsCollection do: [ :event | self applyEvent: event ]
]

{ #category : #'applying events' }
EDAAggregateRoot >> applyEventsIgnoringExceptions: eventsCollection [
	eventsCollection
		do: [ :event | 
			[ self applyEvent: event ]
				on: EDADomainException 
				do: [ :ex | ex resume ] ]
]

{ #category : #accessing }
EDAAggregateRoot >> brandNew [
	^ brandNew
]

{ #category : #accessing }
EDAAggregateRoot >> brandNew: aBoolean [
	brandNew := aBoolean
]

{ #category : #helpers }
EDAAggregateRoot >> buildApplyEventMethodNameForEvent: eventName andVersion: eventVersion [
	^ String streamContents: [ :s | s nextPutAll: 'apply'; nextPutAll: eventName greaseString; nextPut: $v; nextPutAll: eventVersion greaseString; nextPut: $: ]
]

{ #category : #helpers }
EDAAggregateRoot >> buildArgsForCommand: aCommand [
	| attributes |
	attributes := aCommand asDictionary.
	self class changeCommonArgsForCommandAttributes: aCommand asDictionary.
	attributes at: 'aggregateRootVersion' put: self version.
	^ attributes
]

{ #category : #helpers }
EDAAggregateRoot >> buildCommonArgsForCommand: aCommand [
	| result |
	result := self class buildCommonArgsForCommand: aCommand.
	result at: 'aggregateRootVersion' put: self version.
	^ result
]

{ #category : #'command checking' }
EDAAggregateRoot >> checkAggregateExistenceIssuesOnCommand: aCommand [
	aCommand isForNonExistentAggregate
		ifTrue: [ self checkCommandForNonExistentAggregate: aCommand ]
		ifFalse: [ self checkCommandForExistentAggregate: aCommand ]
]

{ #category : #'command checking' }
EDAAggregateRoot >> checkCommandForExistentAggregate: aCommand [
	^ self defaultCheckNonCreateCommand: aCommand
]

{ #category : #'command checking' }
EDAAggregateRoot >> checkCommandForNonExistentAggregate: aCommand [
	aCommand aggregateRootVersion = 0
		ifFalse: [ self
			logWarningMessage:
				'Received create command with aggregate root version '
				, aCommand aggregateRootVersion greaseString.
				aCommand aggregateRootVersion: 0 ].
			self brandNew
				ifFalse: [ self
						logErrorMessage:
							(String
								streamContents: [ :s | 
									s
										nextPutAll: self class greaseString;
										nextPutAll: ' with ';
										nextPutAll: aCommand aggregateSelectionCriteria greaseString;
										nextPutAll: ' already exists in tenant ';
										nextPutAll: aCommand tenant greaseString ])
						andThrow: aCommand class alreadyExistingAggregateExceptionClass ]
]

{ #category : #'command checking' }
EDAAggregateRoot >> checkTenantOfCommand: aCommand [
	self class checkTenantIsValid: aCommand tenant.
	self flag: #TODO.
	"Replace by search in Tenant repository when implemented"
	(aCommand isForNonExistentAggregate isNotNil and:
		[ aCommand isForNonExistentAggregate not ]) ifTrue:
			[ aCommand tenant = self tenant 
				ifFalse: [  self
					logErrorMessage:
						(String
							streamContents: [ :s | 
								s
									nextPutAll: 'Invalid tenant (';
									nextPutAll: aCommand tenant;
									nextPutAll: '), aggregate''s tenant: ';
									nextPutAll: self tenant greaseString ])
					andThrow: InvalidTenant ] ].
]

{ #category : #'command checking' }
EDAAggregateRoot >> defaultCheckNonCreateCommand: aCommand [
	self brandNew
		ifTrue: [ self
				logErrorMessage:
					(String
						streamContents: [ :s | 
							s
								nextPutAll: self class greaseString;
								nextPutAll: ' with ';
								nextPutAll: aCommand aggregateSelectionCriteria keys first greaseString;
								nextPutAll: ' equals to ';
								nextPutAll: aCommand aggregateSelectionCriteria values first greaseString;
								nextPutAll: ' does not exist in tenant ';
								nextPutAll: aCommand tenant greaseString ])
				andThrow: aCommand class invalidCommandExceptionClass ]
]

{ #category : #helpers }
EDAAggregateRoot >> deleteCommandResultEventClass [
	| candidates |
	candidates := EDADeleteCommandResultEvent allSubclasses
		select: [ :cls | 
			cls aggregateRootClass = self class
				and: [ (cls greaseString indexOfSubCollection: 'Test' startingAt: 0) = 0 ] ].
	candidates
		ifEmpty: [ self
				logErrorMessage:
					(String
						streamContents: [ :s |
							s
								nextPutAll: 'Cannot find delete event for aggregate ';
								nextPutAll: self class greaseString ])
				andThrow: MissingDeleteEventClassForAggregate ]
		ifNotEmpty: [ :c | 
			c size > 1
				ifTrue: [ self
						logErrorMessage:
							(String
								streamContents: [ :s |
									s
										nextPutAll: 'Too many delete events for aggregate: ';
										nextPutAll: self class greaseString ]) andThrow: TooManyDeleteEventClassesForAggregate ].
			^ c first ].
]

{ #category : #accessing }
EDAAggregateRoot >> events [
	^ self class aggregateRepository findEventsOfId: self id.
]

{ #category : #'command handling' }
EDAAggregateRoot >> handleDeleteCommand: aCommand [
	self id
		ifNil: [ self
				logErrorMessage: 'id is missing'
				andThrow: (EDAAggregateRootDoesNotExist forClass: self class) ].
	^ self deleteCommandResultEventClass
		ifNotNil: [ :eventClass | 
			eventClass
				ofTenant: self tenant
				withAggregateId: self id
				commandId: aCommand commandId
				andAttributes: aCommand asDictionary ]
]

{ #category : #accessing }
EDAAggregateRoot >> id [
	^ id
]

{ #category : #accessing }
EDAAggregateRoot >> id: anId [
	id := anId
]

{ #category : #initialization }
EDAAggregateRoot >> initialize [
	self version: 0.
	self isDeleted: false.
	self brandNew: true
]

{ #category : #helpers }
EDAAggregateRoot >> is: aString equalTo: anotherString [
	^ (self normalize: aString) = (self normalize: anotherString)
]

{ #category : #initialization }
EDAAggregateRoot >> isDeleted [
	^ isDeleted
]

{ #category : #initialization }
EDAAggregateRoot >> isDeleted: aFlag [
	isDeleted := aFlag
]

{ #category : #helpers }
EDAAggregateRoot >> newVersionAfter: aVersion [
	^ self class newVersionAfter: aVersion
]

{ #category : #helpers }
EDAAggregateRoot >> normalize: aString [
	^ aString greaseString trimmed asLowercase
]

{ #category : #helpers }
EDAAggregateRoot >> retrieveApplyEventMethod: event withLogging: aFlag [
	| aux auxClass auxClassName result found |
	found := false.
	result := nil.
	auxClass := event class.
	auxClassName := auxClass greaseString.
	aux := self
		buildApplyEventMethodNameForEvent: auxClassName
		andVersion: event version.
	[ found ]
		whileFalse: [ [ auxClassName isNotEmpty ]
				whileTrue: [ (self respondsTo: aux asSymbol)
						ifTrue: [
							found := true.
							^ aux ]
						ifFalse: [ aFlag
								ifTrue: [ self
										logTraceMessage: ((WriteStream on: String new) nextPutAll: self class greaseString; nextPutAll: '>>'; nextPutAll: aux; nextPutAll: ' not found.'; close; contents) ] ].
					auxClassName := auxClassName allButFirst.
					aux := self
						buildApplyEventMethodNameForEvent: auxClassName
						andVersion: event version ].
			auxClass := auxClass superclass.
			auxClassName := auxClass greaseString.
			found := auxClass ~= EDAEventSourcingEvent.
			aux := self
				buildApplyEventMethodNameForEvent: auxClass greaseString
				andVersion: event version ].
	^ result
]

{ #category : #accessing }
EDAAggregateRoot >> scopeContext [
	^ scopeContext
]

{ #category : #accessing }
EDAAggregateRoot >> scopeContext: aDictionary [
	scopeContext := aDictionary
]

{ #category : #accessing }
EDAAggregateRoot >> scopeKey [
	^ scopeKey
]

{ #category : #accessing }
EDAAggregateRoot >> scopeKey: anObject [
	scopeKey := anObject
]

{ #category : #accessing }
EDAAggregateRoot >> tenant [
	^ tenant
]

{ #category : #accessing }
EDAAggregateRoot >> tenant: aString [
	tenant ifNil: [ tenant := aString greaseString ] ifNotNil: [ :t | t = aString ifFalse: [ self logErrorMessage: 'Tenant cannot be modified. Original: ', t greaseString, ', rejected: ', aString greaseString ] ].
]

{ #category : #accessing }
EDAAggregateRoot >> version [
	^ version
]

{ #category : #accessing }
EDAAggregateRoot >> version: aNumber [
	version := aNumber
]
