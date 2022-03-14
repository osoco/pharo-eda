Class {
	#name : #EDACommand,
	#superclass : #Object,
	#traits : 'EDAPrintOnHelper + EDATCollectionHelper + EDATHashHelper + EDATEqualsHelper',
	#classTraits : 'EDAPrintOnHelper classTrait + EDATCollectionHelper classTrait + EDATHashHelper classTrait + EDATEqualsHelper classTrait',
	#instVars : [
		'tenant',
		'applicationKey',
		'commandId',
		'aggregateRootId',
		'originalTimestamp',
		'aggregateRootVersion',
		'version',
		'aggregateRootClass',
		'scopeContext',
		'agent'
	],
	#classInstVars : [
		'latestVersion'
	],
	#category : #'EDA-Commands-Commands'
}

{ #category : #meta }
EDACommand class >> aggregateRootClass [
	self subclassResponsibility 
]

{ #category : #helpers }
EDACommand class >> aggregateRootClassNameWithoutPrefix [
	^ self aggregateRootClass asString allButFirst: self classPrefix size
]

{ #category : #override }
EDACommand class >> alreadyExistingAggregateExceptionClass [
	^ EDAAlreadyExistingAggregate allSubclasses
		detect:
			[ :class | class exceptionForAggregateRootClass: self aggregateRootClass ]
		ifNone: [ EDAAlreadyExistingAggregate ]
]

{ #category : #helpers }
EDACommand class >> classPrefix [
	^ (self name regex: '^([A-Z]+)' matchesCollect: [ :each | each asString ]) first allButLast
]

{ #category : #override }
EDACommand class >> invalidCommandExceptionClass [
	^ EDAInvalidCommandMessage
]

{ #category : #accessing }
EDACommand class >> latestVersion [
	<doc: 'Updates the latest version of the command class'>
	self subclassResponsibility
]

{ #category : #checking }
EDACommand class >> nonNullableAttributes [
	"Fill in subclasses with non-nullable InstVar as symbols"
	"Override invalidNonNullableAttributesErrorLogs instance side to customize error logs"
	[ self subclassResponsibility ]
		on: Error
		do: [ ^ Set empty ]
	
]

{ #category : #meta }
EDACommand class >> ofTenant: theTenant withCommandId: theCommandId aggregateRootVersion: theVersion andAttributes: theAttributes [
	| result |
	result := self new.
	result tenant: theTenant.
	result commandId: theCommandId.
	result aggregateRootVersion: theVersion.
	result version: (theAttributes at: 'version' ifAbsent: [ self latestVersion  ]).
	theAttributes at: 'agent' ifPresent: [ :v | result agent: v ].
	theAttributes
		at: 'aggregateRootClass'
		ifPresent: [ :v | result aggregateRootClass: v ].
	theAttributes
		at: 'id'
		ifPresent: [ :v | result aggregateRootId: v ].
	^ result
]

{ #category : #accessing }
EDACommand >> agent [
	^ agent
]

{ #category : #accessing }
EDACommand >> agent: aString [
	agent := aString
]

{ #category : #accessing }
EDACommand >> aggregateRootClass [
	^ aggregateRootClass
]

{ #category : #accessing }
EDACommand >> aggregateRootClass: aClass [
	aggregateRootClass := aClass
]

{ #category : #helpers }
EDACommand >> aggregateRootClassNameWithoutPrefix [
	^ self class aggregateRootClassNameWithoutPrefix
]

{ #category : #accessing }
EDACommand >> aggregateRootId [
	^ aggregateRootId
]

{ #category : #accessing }
EDACommand >> aggregateRootId: anObject [
	aggregateRootId := anObject
]

{ #category : #accessing }
EDACommand >> aggregateRootVersion [
  | result |
  result := aggregateRootVersion.
  result ifNil: [ result := 0. self aggregateRootVersion: result ].
  ^ result
]

{ #category : #accessing }
EDACommand >> aggregateRootVersion: anObject [
	aggregateRootVersion := anObject
]

{ #category : #'aggregate selection' }
EDACommand >> aggregateSelectionCriteria [
	^ Dictionary with: 'id' -> self aggregateRootId
]

{ #category : #accessing }
EDACommand >> applicationKey [
	^ applicationKey
]

{ #category : #accessing }
EDACommand >> applicationKey: anObject [
	applicationKey := anObject
]

{ #category : #'aggregate checking' }
EDACommand >> checkForAggregateRoot: anAggregateRoot [
"super checkForAggregateRoot: in the subclasses and add the specific validations necessary for the command"
	anAggregateRoot checkCreateNonCreateIssuesOnCommand: self.
	anAggregateRoot checkTenantOfCommand: self.
]

{ #category : #helpers }
EDACommand >> classNameWithoutPrefix [
	^ self class name asString allButFirst: (self classPrefix) size
]

{ #category : #helpers }
EDACommand >> classPrefix [
	^ self class classPrefix
]

{ #category : #accessing }
EDACommand >> commandId [
	^ commandId
]

{ #category : #accessing }
EDACommand >> commandId: anObject [
	commandId := anObject
]

{ #category : #checking }
EDACommand >> errorLogForInvalidNonNullableAttribute: aInstVarSymbol [
	^ self invalidNonNullableAttributesErrorLogs at: aInstVarSymbol ifAbsent: [ nil ]
]

{ #category : #helpers }
EDACommand >> extractScopeKey: aDictionary target: aString accummulator: anOrderedCollection [
	| result |
	result := OrderedCollection new.
	(aDictionary isNotNil and: [ aString isNotNil ])
		ifTrue: [ (aDictionary keys
				reject: [ :key | (OrderedCollection with: 'id' with: 'scope') includes: key ])
				do: [ :key |
					key = aString
						ifTrue: [ anOrderedCollection
								ifNotEmpty: [ :c | result addAll: (self flatten: c) ].
							result add: ((aDictionary at: key) at: 'id') ]
						ifFalse: [ | accum |
							accum := OrderedCollection new.
							anOrderedCollection
								ifNotEmpty: [ :c | accum addAll: (self flatten: c) ].
							accum add: ((aDictionary at: key) at: 'id').
							result
								addAll:
									(self
										extractScopeKey: (aDictionary at: key)
										target: aString
										accummulator: accum) ] ] ].
	^ result
]

{ #category : #helpers }
EDACommand >> fillCommonInfoInto: aDict [
	aDict at: #commandId put: self commandId.
	aDict at: #id put: self aggregateRootId.
	aDict at: #version put: self aggregateRootVersion
]

{ #category : #checking }
EDACommand >> invalidNonNullableAttributes [
	"Return not nullable attributes = nil
	Note that attribute getters are required"
	^ self class nonNullableAttributes
		select: [ :att |
			(att value: self) isNil ]
]

{ #category : #checking }
EDACommand >> invalidNonNullableAttributesErrorLogs [
	"Return a Dictionary with
	key: invalidNonNullableAttribute InstVar as symbol
	value: string with error log"
	[ self subclassResponsibility ]
		on: Error
		do: [ ^ Dictionary empty ]
]

{ #category : #helpers }
EDACommand >> isCreate [
	^ self classNameWithoutPrefix
	= ('Create' , self aggregateRootClassNameWithoutPrefix)
]

{ #category : #helpers }
EDACommand >> isDelete [
	^ false
]

{ #category : #accessing }
EDACommand >> originalTimestamp [
	^ originalTimestamp
]

{ #category : #accessing }
EDACommand >> originalTimestamp: anObject [
	originalTimestamp := anObject
]

{ #category : #accessing }
EDACommand >> scopeContext [
	^ scopeContext

]

{ #category : #accessing }
EDACommand >> scopeContext: aDictionary [
	scopeContext := aDictionary

]

{ #category : #accessing }
EDACommand >> scopeKey [
	^ self scopeContext
		ifNil: [ nil ]
		ifNotNil: [ :ctx |
			self
				extractScopeKey: (ctx at: 'scopes' ifAbsent: [ nil ] )
				target: (ctx at: 'scope' ifAbsent: [ nil ])
				accummulator: OrderedCollection new ]
]

{ #category : #accessing }
EDACommand >> tenant [
	^ tenant
]

{ #category : #accessing }
EDACommand >> tenant: aTenant [
	tenant := aTenant
]

{ #category : #accessing }
EDACommand >> version [
	^ version
]

{ #category : #accessing }
EDACommand >> version: aNumber [
	version := aNumber
]
