Class {
	#name : #EDADomainTestGenerator,
	#superclass : #EDAGenerator,
	#category : 'EDA-Tools'
}

{ #category : #asserting }
EDADomainTestGenerator class >> shouldRunAfter: anotherGenerator [
	^ anotherGenerator = EDADomainTestEventGenerator
]

{ #category : #'code generation' }
EDADomainTestGenerator >> createDomainTestClass [
	| cls |
	cls := (self appName , self aggregate capitalized , 'AggregateTestCase') asSymbol.
	(self containsAnyDisableRegenerationMethod: cls)
		ifFalse: [ ^ BabyMock2TestCase
				subclass: (self appName , self aggregate capitalized , 'AggregateTestCase') asSymbol
				uses: EDATDomainBDD + (Smalltalk at: (self appName , 'T' , self aggregate capitalized , 'TestHelper') asSymbol)
				instanceVariableNames: ''
				classVariableNames: ''
				package: self appName , '-Domain-Tests-' , (self toCamelCase: self aggregate ) ]
]

{ #category : #'code generation' }
EDADomainTestGenerator >> createDomainTestMethod [
	^ self
		compile: self generateDomainTestMethodName
		sourceCode: self generateDomainTestMethod
		inClass: (self class environment at: (self appName , self aggregate capitalized , 'AggregateTestCase') asSymbol)
		classifiedAs: self protocol
]

{ #category : #delegated }
EDADomainTestGenerator >> createTestEventBuildEventClassMethod [
	| delegate |
	delegate := EDADomainTestEventGenerator
		fromExampleFile: self commandFile
		version: self version
		appName: self appName
		aggregate: self aggregate
		commandNameResolver: self commandNameResolver
		andEventNameResolver: self eventNameResolver.
	^ delegate createTestEventBuildEventClassMethod
]

{ #category : #delegated }
EDADomainTestGenerator >> createTestHelperBuildCommandMethod [
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

{ #category : #delegated }
EDADomainTestGenerator >> createTestHelperBuildEventClassMethod [
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

{ #category : #delegated }
EDADomainTestGenerator >> createTestHelperBuildEventMethod [
	| delegate |
	delegate := EDATestTraitGenerator
		fromExampleFile: self commandFile
		version: self version
		appName: self appName
		aggregate: self aggregate
		commandNameResolver: self commandNameResolver
		andEventNameResolver: self eventNameResolver.
	^ delegate createTestHelperBuildEventMethod
]

{ #category : #protected }
EDADomainTestGenerator >> description [
	^ 'domain test for ' , self aggregate greaseString
]

{ #category : #protected }
EDADomainTestGenerator >> doGenerate [
	self createDomainTestClass.
	self createDomainTestMethod.
	self createTestHelperBuildCommandMethod.
	self createTestHelperBuildEventMethod.
	self createTestEventBuildEventClassMethod.
	self createTestHelperBuildEventClassMethod.
]

{ #category : #'code generation' }
EDADomainTestGenerator >> generateDomainTestMethod [
	| result cmdName evtName cr |
	cr := Character cr.
	cmdName := self toCamelCase: self commandName.
	evtName := self toCamelCase: self eventName.
	result := WriteStream with: String new.
	result nextPutAll: self generateDomainTestMethodName.
	result nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	| command event |';
		nextPut: cr.
	result
		nextPutAll: '	command := self build';
		nextPutAll: cmdName;
		nextPutAll: 'SampleCommand.';
		nextPut: cr.
	result
		nextPutAll: '	event := self build'.
	self isDeletedEvent
		ifTrue: [
			result
				nextPutAll: 'DeletedEventWithId: ''<ANYTHING>'' ';
				nextPutAll: 'andCommand: command.'
		] ifFalse: [
			result
				nextPutAll: evtName;
				nextPutAll: 'SampleEventWithId: ''<ANYTHING>'' ';
				nextPutAll: 'andCommandId: command commandId.'
		].
	result
		nextPut: cr.
	result
		nextPutAll: '	self';
		nextPut: cr.
	result
		nextPutAll: '		givenAggregate: #';
		nextPutAll: self appName;
		nextPutAll: self aggregate capitalized;
		nextPut: cr.
	result
		nextPutAll: '			withEvents: OrderedCollection new';
		nextPut: cr.
	result
		nextPutAll: '			whenReceiveCommand: command';
		nextPut: cr.
	result
		nextPutAll: '			thenEvent: event';
		nextPut: cr.
	^ result contents
]

{ #category : #'code generation' }
EDADomainTestGenerator >> generateDomainTestMethodName [
	^ 'test' , (self toCamelCase: self commandName)
]

{ #category : #delegated }
EDADomainTestGenerator >> generateEventClassAggregateRootClassMethod [
	| delegate |
	delegate := EDAEventGenerator
		fromExampleFile: self commandFile
		version: self version
		appName: self appName
		aggregate: self aggregate
		commandNameResolver: self commandNameResolver
		andEventNameResolver: self eventNameResolver.
	^ delegate generateEventClassAggregateRootClassMethod
]
