Class {
	#name : #EDAAggregateRoot,
	#superclass : #Object,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#instVars : [
		'id',
		'version',
		'isDeleted',
		'scopeContext',
		'scopeKey',
		'brandNew'
	],
	#category : #'EDA-Domain-Aggregate'
}

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
EDAAggregateRoot class >> checkTenantIsValid: tenantOfCommand [
	^ tenantOfCommand isNotNil
]

{ #category : #helpers }
EDAAggregateRoot class >> checkTenantOfCommand: aCommandTenant matches: anAggregateTenant [
	| result |
	result := (self checkTenantIsValid: aCommandTenant)
		ifTrue: [ aCommandTenant = anAggregateTenant ]
		ifFalse: [ false ].
	result
		ifFalse: [ self
				logErrorMessage:
					(String
						streamContents: [ :s |
							s
								nextPutAll: 'Invalid tenant (';
								nextPutAll: aCommandTenant;
								nextPutAll: '), aggregate''s tenant: ';
								nextPutAll: anAggregateTenant greaseString ])
				andThrow: InvalidTenant ]
]

{ #category : #helpers }
EDAAggregateRoot class >> checkTenantOfCommandIsValid: aCommand [
	(self checkTenantIsValid: aCommand tenant)
		ifFalse:
			[ self logErrorMessage: 'tenant is missing' andThrow: InvalidTenant ]
]

{ #category : #ui }
EDAAggregateRoot class >> systemIcon [
	^ Smalltalk ui icons iconNamed: #objects
]

{ #category : #accessing }
EDAAggregateRoot >> aggregateRepository [
	self subclassResponsibility
]

{ #category : #'event handling' }
EDAAggregateRoot >> applyAggregateDeletedEvent: anEvent [
	self isDeleted: true
]

{ #category : #'event handling' }
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
					self brandNew: false ]
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
					self retrieveApplyEventMethod: anEvent withLogging: true ] ]
]

{ #category : #'event handling' }
EDAAggregateRoot >> applyEvents: eventsCollection [
	eventsCollection do: [ :event | self applyEvent: event ]
]

{ #category : #'event handling' }
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

{ #category : #helper }
EDAAggregateRoot >> buildApplyEventMethodNameForEvent: eventName andVersion: eventVersion [
	^ String streamContents: [ :s | s nextPutAll: 'apply'; nextPutAll: eventName greaseString; nextPut: $v; nextPutAll: eventVersion greaseString; nextPut: $: ]
]

{ #category : #helper }
EDAAggregateRoot >> buildDeleteCommandResultEvent [
	| result eventClass candidates |
	eventClass := nil.
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
			eventClass := c first ].
	result := eventClass ifNotNil: [ :cls | cls new ].
	^ result
]

{ #category : #accessing }
EDAAggregateRoot >> events [
	^ self aggregateRepository findEventsById: self id.
]

{ #category : #'event handling' }
EDAAggregateRoot >> handleDeleteCommand: aCommand [
	| result |
	self id
		ifNil: [ self
				logErrorMessage: 'id is missing'
				andThrow: (EDAAggregateRootDoesNotExist forClass: self class) ].
	result := self buildDeleteCommandResultEvent.
	result
		ifNotNil: [ :r | 
			r tenant: aCommand tenant.
			r id: self id.
			r commandId: aCommand commandId.
			r version: 1.
			r timestamp: DateAndTime new asUTC ].
	^ result
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

{ #category : #helper }
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

{ #category : #helper }
EDAAggregateRoot >> normalize: aString [
	^ aString greaseString trimmed asLowercase
]

{ #category : #helper }
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
				whileTrue: [ self class methodDictionary
						at: aux asSymbol
						ifPresent: [ :v | 
							found := true.
							^ aux ]
						ifAbsent: [ aFlag
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
EDAAggregateRoot >> version [
	^ version
]

{ #category : #accessing }
EDAAggregateRoot >> version: aNumber [
	version := aNumber
]
