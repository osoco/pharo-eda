Class {
	#name : #EDADomainTestEventGenerator,
	#superclass : #EDAGenerator,
	#category : 'EDA-Tools'
}

{ #category : #asserting }
EDADomainTestEventGenerator class >> shouldRunAfter: anotherGenerator [
	^ anotherGenerator ~= EDATestSupportGenerator and: [ anotherGenerator ~= EDADomainTestGenerator ]
]

{ #category : #'code generation' }
EDADomainTestEventGenerator >> createDomainTestEventClass [
	| cls parent parentSymbol |
	parentSymbol := self isDeletedEvent
		ifTrue: [ (self appName , (self toCamelCase: self eventName)) asSymbol ]
		ifFalse: [ self retrieveEventClassName asSymbol].
	parent := self class environment at: parentSymbol.
	cls := self retrieveDomainTestEventClassName.
	parent
		subclass: cls
		uses: EDATTestEvent
		instanceVariableNames: ''
		classVariableNames: ''
		package: self appName , '-Domain-Tests-' , (self toCamelCase: self aggregate).
	^ cls
]

{ #category : #'code generation' }
EDADomainTestEventGenerator >> createDomainTestEventClassAggregateRootClassMethod [
	| cls |
	cls := self class environment at: self retrieveEventClassName asSymbol.
	^ self
		compile: 'aggregateRootClass'
		sourceCode: self generateEventClassAggregateRootClassMethod
		inClass: cls class
		classifiedAs: 'meta'
]

{ #category : #'code generation' }
EDADomainTestEventGenerator >> createDomainTestEventEqualsMethod [
	^ self
		compile: '='
		sourceCode: self generateDomainTestEventEqualsMethod
		inClass: (self retrieveDomainTestEventClass)
		classifiedAs: self protocol
]

{ #category : #delegated }
EDADomainTestEventGenerator >> createTestEventBuildEventClassMethod [
	| method |
	method := self generateTestEventBuildEventClassMethod.
	method
		associationsDo: [ :assoc | 
			^ self
				compile: assoc key
				sourceCode: assoc value
				inClass: self retrieveDomainTestEventClass class
				classifiedAs: self protocol ]
]

{ #category : #'code generation' }
EDADomainTestEventGenerator >> createTestHelperBuildCommandMethod [
	| delegate |
	delegate := EDATestTraitGenerator
		fromExampleFile: self commandFile
		version: self version
		appName: self appName
		aggregate: self aggregate
		commandNameResolver: self commandNameResolver
		andEventNameResolver: self eventNameResolver.
	^ delegate createTestHelperBuildCommandMethod
]

{ #category : #'code generation' }
EDADomainTestEventGenerator >> createTestHelperBuildEventClassMethod [
	| delegate |
	delegate := EDATestSupportGenerator
		fromExampleFile: self commandFile
		version: self version
		appName: self appName
		aggregate: self aggregate
		commandNameResolver: self commandNameResolver
		andEventNameResolver: self eventNameResolver.
	^ delegate createTestHelperBuildEventClassMethod
]

{ #category : #protected }
EDADomainTestEventGenerator >> description [
	^ 'domain test event for ' , self aggregate greaseString
]

{ #category : #protected }
EDADomainTestEventGenerator >> doGenerate [
	self createDomainTestEventClass.
	self createTestEventBuildEventClassMethod.
	self createTestHelperBuildEventClassMethod.
	self createDomainTestEventEqualsMethod.
	self createTestEventBuildEventClassMethod
]

{ #category : #'code generation' }
EDADomainTestEventGenerator >> generateDomainTestEventAttributeMatchesMethodName [
	^ 'attribute:named:matches:'
]

{ #category : #'code generation' }
EDADomainTestEventGenerator >> generateDomainTestEventEqualsAndBlockRecursively: attributes [
	| result attribute |
	attributes size > 0
		ifTrue: [ attribute := attributes first.
			result := ' (self attribute: self ' , attribute , ' named: ''' , attribute , ''' matches: anInstance ' , attribute , ')'.
			attributes size > 1
				ifTrue: [ result := result , ' and: [ ' , (self generateDomainTestEventEqualsAndBlockRecursively: attributes allButFirst) , ' ]' ] ].
	^ result
]

{ #category : #'code generation' }
EDADomainTestEventGenerator >> generateDomainTestEventEqualsMethod [
	| result cr eventAttributes |
	eventAttributes := self
		allAttributesOf: self retrieveDomainTestEventClass
		including: (self retrieveEventAttributesBut: self class skippedEventAttributes).
	result := WriteStream with: String new.
	cr := Character cr.
	result
		nextPutAll: '= anInstance';
		nextPut: Character cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	^ ';
		nextPutAll: ' (anInstance class isKindOf: '.
	result nextPutAll: self retrieveEventClassName.
	result
		nextPutAll: ' class) and: [';
		nextPut: cr.
	result
		nextPutAll:
			'		(self attribute: self aggregateRootClass matches: anInstance aggregateRootClass) and: [';
		nextPut: cr.
	result
		nextPutAll:
			'		(self attribute: self tenant matches: anInstance tenant) and: [';
		nextPut: cr.
	result
		nextPutAll:
			'				(self attribute: self id named: ''id'' matches: anInstance id) and: [';
		nextPut: cr.
	result
		nextPutAll:
			'					(self attribute: self aggregateRootVersion matches: anInstance aggregateRootVersion) and: [';
		nextPut: cr.
	result
		nextPutAll:
			'						(self attribute: self timestamp named: ''timestamp'' matches: anInstance timestamp) and: [';
		nextPut: cr.
	result
		nextPutAll:
			'							(self attribute: self commandId named: ''correlationId'' matches: anInstance commandId) '.
	self isDeletedEvent
		ifFalse: [ eventAttributes isNotEmpty
				ifTrue: [ result
						nextPutAll: 'and: [';
						nextPut: cr.
					result
						nextPutAll: '								';
						nextPutAll:
							(self
								generateDomainTestEventEqualsAndBlockRecursively: (self retrieveEventAttributesBut: self class skippedEventAttributes));
						nextPut: cr.
					result
						nextPutAll: '						]';
						nextPut: cr ] ].
	result
		nextPutAll: '						]';
		nextPut: cr.
	result
		nextPutAll: '					]';
		nextPut: cr.
	result
		nextPutAll: '				]';
		nextPut: cr.
	result
		nextPutAll: '			]';
		nextPut: cr.
	result
		nextPutAll: '		]';
		nextPut: cr.
	result
		nextPutAll: '	]';
		nextPut: cr.
	^ result contents
]

{ #category : #'code generation' }
EDADomainTestEventGenerator >> generateTestEventBuildEventClassMethod [
	| method attrs result cr |
	cr := Character cr.
	method := WriteStream with: String new.
	method
		nextPutAll: (self generateTestEventBuildEventClassMethodNameWithArgPrefix: 'new');
		nextPut: cr.
	method nextPutAll: self generateSignature.
	attrs := self
		retrieveEventAttributesBut: self class skippedCommandAttributes.
	method
		nextPut: cr;
		nextPutAll: '	| result |';
		nextPut: cr.
	method
		nextPutAll: '	result := self new.';
		nextPut: cr.
	method
		nextPutAll: '	result tenant: newEvent tenant.';
		nextPut: cr.
	method
		nextPutAll: '	result id: ''<ANYTHING>''.';
		nextPut: cr.
	method
		nextPutAll: '	result commandId: newEvent commandId.';
		nextPut: cr.
	method
		nextPutAll: '	result version: newEvent version.';
		nextPut: cr.
	method
		nextPutAll: '	result aggregateRootVersion: newEvent aggregateRootVersion.';
		nextPut: cr.
	method nextPutAll: '	result timestamp: ''<ANYTHING>''.'.
	attrs
		do: [ :attr | 
			method
				nextPut: cr;
				nextPutAll: '	result ';
				nextPutAll: attr uncapitalized;
				nextPutAll: ': newEvent ';
				nextPutAll: attr;
				nextPut: $. ].
	method
		nextPut: cr;
		nextPutAll: '	^ result'.
	result := Dictionary new.
	result
		at: self generateTestEventBuildEventClassMethodName
		put: method contents.
	^ result
]

{ #category : #'code generation' }
EDADomainTestEventGenerator >> generateTestEventBuildEventClassMethodName [
	^ 'fromEvent:'
]

{ #category : #'code generation' }
EDADomainTestEventGenerator >> generateTestEventBuildEventClassMethodNameWithArgPrefix: prefix [
	^ 'fromEvent: ' , prefix , 'Event'
]

{ #category : #delegated }
EDADomainTestEventGenerator >> retrieveDomainTestEventClass [
	| cls result |
	cls := self class environment at: self retrieveDomainTestEventClassName ifAbsent: [ nil ].
	result := cls ifNotNil: [ :c | c ] ifNil: [ self createDomainTestEventClass ].
	^ result
]

{ #category : #'code generation' }
EDADomainTestEventGenerator >> retrieveDomainTestEventClassName [
	^ (self appName , 'Test' , (self toCamelCase: self eventName)) asSymbol
]
