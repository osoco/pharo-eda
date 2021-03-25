Class {
	#name : #EDATestTraitGenerator,
	#superclass : #EDAGenerator,
	#category : #'EDA-Tools'
}

{ #category : #'code generation' }
EDATestTraitGenerator >> createReadCommandFromFileTestHelperMethod [
	^ (Smalltalk at: self retrieveTestHelperTraitName asSymbol)
		compile: self generateReadCommandFromFileTestHelperMethod
		classified: self protocol
]

{ #category : #'code generation' }
EDATestTraitGenerator >> createReadEventFromFileTestHelperMethod [
	^ (Smalltalk at: self retrieveTestHelperTraitName asSymbol)
		compile: self generateReadEventFromFileTestHelperMethod
		classified: self protocol
]

{ #category : #delegated }
EDATestTraitGenerator >> createTestEventBuildEventClassMethod [
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

{ #category : #'code generation' }
EDATestTraitGenerator >> createTestHelperBuildCommandMethod [
	^ (Smalltalk at: self retrieveTestHelperTraitName asSymbol)
		compile:	self generateTestHelperBuildCommandMethod
		classified: self protocol
			

]

{ #category : #'code generation' }
EDATestTraitGenerator >> createTestHelperBuildEventFromArbitraryFileMethod [
	self isDeletedEvent
		ifFalse: [
			(Smalltalk at: self retrieveTestHelperTraitName asSymbol)
			compile:	self generateTestHelperBuildEventFromArbitraryFileMethod
			classified: self protocol
		]
]

{ #category : #'code generation' }
EDATestTraitGenerator >> createTestHelperBuildEventMethod [
	^ (Smalltalk at: self retrieveTestHelperTraitName asSymbol)
		compile:
			(self isDeletedEvent
				ifTrue: [
					self generateTestHelperBuildDeleteEventMethod
				] ifFalse: [
					self generateTestHelperBuildEventMethod
				])
		classified: self protocol
]

{ #category : #'code generation' }
EDATestTraitGenerator >> createTestHelperTrait [
	| trait |
	trait := self retrieveTestHelperTraitName asSymbol.
	^ Trait named: trait uses: #() category: self appName , '-Domain-Tests-' , (self toCamelCase: self aggregate)
]

{ #category : #protected }
EDATestTraitGenerator >> description [
	^ 'test helper trait for ' , self eventName greaseString
]

{ #category : #protected }
EDATestTraitGenerator >> doGenerate [
	self createTestHelperTrait.
	self createTestHelperBuildCommandMethod.
	self createTestHelperBuildEventFromArbitraryFileMethod.
	self createTestHelperBuildEventMethod.
	self createReadCommandFromFileTestHelperMethod.
	self createReadEventFromFileTestHelperMethod
]

{ #category : #delegated }
EDATestTraitGenerator >> generateCommandClassBuilderMethodNameWithArgPrefix: aString [ 
	| delegate |
	delegate := EDACommandGenerator fromExampleFile: self commandFile
				version: self version
				appName: self appName
				aggregate: self aggregate
				commandNameResolver: self commandNameResolver
				andEventNameResolver: self eventNameResolver.
	^ delegate generateCommandClassBuilderMethodNameWithArgPrefix: aString
]

{ #category : #'code generation' }
EDATestTraitGenerator >> generateReadCommandFromFileTestHelperMethod [
	^ self
		generateReadFromFileTestHelperMethod: self generateReadCommandFromFileTestHelperMethodName
		for: self commandName
		ofType: 'commands'
]

{ #category : #'code generation' }
EDATestTraitGenerator >> generateReadCommandFromFileTestHelperMethodName [
	^ 'read' , (self toCamelCase: self commandName) , 'FromFile'
]

{ #category : #'code generation' }
EDATestTraitGenerator >> generateReadEventFromArbitraryFileTestHelperMethod [
	^ self
		generateReadFromFileTestHelperMethod: self generateReadEventFromArbitraryFileTestHelperMethodName
		for: self eventName
		ofType: 'events'
]

{ #category : #'code generation' }
EDATestTraitGenerator >> generateReadEventFromArbitraryFileTestHelperMethodName [
	^ 'read' , (self toCamelCase: self eventName) , 'FromFile:'
]

{ #category : #'code generation' }
EDATestTraitGenerator >> generateReadEventFromFileTestHelperMethod [
	^ self generateReadFromFileTestHelperMethod: self generateReadEventFromFileTestHelperMethodName for: self eventName ofType: 'events'
]

{ #category : #'code generation' }
EDATestTraitGenerator >> generateReadEventFromFileTestHelperMethodName [
	^ 'read' , (self toCamelCase: self eventName) , 'FromFile'
]

{ #category : #'code generation' }
EDATestTraitGenerator >> generateReadFromFileTestHelperMethod: methodName for: resourceName ofType: type [
	| result cr relativeFolders |
	cr := Character cr.
	result := WriteStream with: String new.
	result
		nextPutAll: methodName;
		nextPut: cr.
	result nextPutAll: self generateSignature.
	result nextPutAll: '	^ self readFile: (FileSystem disk workingDirectory '.
	relativeFolders := (self findRelativePathBetweenFile: self commandFile andFolder: FileSystem disk workingDirectory).
	relativeFolders removeLast;removeLast.
	relativeFolders
		do: [ :subfolder | 
			result
				nextPutAll: ' / ''';
				nextPutAll: subfolder;
				nextPutAll: '''' ].
	result
		nextPutAll: ' / ''';
		nextPutAll: type;
		nextPutAll: ''' / ''v';
		nextPutAll: self version greaseString;
		nextPutAll: ''' / ''';
		nextPutAll: (self upcasedToDotSeparated: resourceName);
		nextPutAll: '.example.json'')';
		nextPut: cr.
	^ result contents
]

{ #category : #'code generation' }
EDATestTraitGenerator >> generateTestHelperBuildCommandMethod [
	| result cr commandAttrs cmdName |
	cr := Character cr.
	commandAttrs := self retrieveCommandAttributes.
	cmdName := self toCamelCase: self commandName.
	result := WriteStream with: String new.
	result nextPutAll: self generateTestHelperBuildCommandMethodName.
	result nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll:
			'    | commandMessage commandJson commandMeta commandBody cmdTenant cmdCommandId cmdVersion cmdContractVersion cmdAttributes result |';
		nextPut: cr.
	result
		nextPutAll: '	commandMessage := self read';
		nextPutAll: (self toCamelCase: cmdName);
		nextPutAll: 'FromFile.';
		nextPut: cr.
	result
		nextPutAll: '	commandJson := NeoJSONReader fromString: commandMessage.';
		nextPut: cr.
	result
		nextPutAll: '	commandMeta := commandJson at: #meta.';
		nextPut: cr.
	result
		nextPutAll: '	commandBody := commandJson at: #body.';
		nextPut: cr.
	result
		nextPutAll:
			'	cmdTenant := commandBody at: ''tenant'' ifPresent: [ :v | v ] ifAbsent: [ nil ].';
		nextPut: cr.
	result
		nextPutAll:
			'	cmdCommandId := commandMeta at: ''id'' ifPresent: [ :v | v ] ifAbsent: [ UUID new greaseString ].';
		nextPut: cr.
	result
		nextPutAll: '	cmdAttributes := Dictionary new.';
		nextPut: cr.
	result
		nextPutAll: '	cmdContractVersion := commandMeta at: ''version'' ifAbsent: [ ';
		nextPutAll: self version greaseString;
		nextPutAll: ' ].';
		nextPut: cr.
	result
		nextPutAll: '	cmdAttributes at: ''version'' put: cmdContractVersion.';
		nextPut: cr.
	result
		nextPutAll: '	cmdVersion := commandBody at: ''version'' ifAbsent: [ 0 ].';
		nextPut: cr.
	result
		nextPutAll: '	cmdAttributes at: ''aggregateRootVersion'' put: cmdVersion.';
		nextPut: cr.
	(commandAttrs select: [ :a | a ~= 'version' ])
		do: [ :attr | 
			result
				nextPutAll: '	commandBody at: ''';
				nextPutAll: attr;
				nextPutAll: ''' ifPresent: [ :v | cmdAttributes at: ''';
				nextPutAll: attr;
				nextPutAll: ''' put: v ].';
				nextPut: cr ].
	result nextPutAll: '	result := '.
	self isDeleteCommand
		ifTrue: [ result nextPutAll: 'EDADeleteAggregateCommand' ]
		ifFalse: [ result
				nextPutAll: self appName;
				nextPutAll: cmdName ].
	result
		nextPut: Character space;
		nextPutAll: (self generateCommandClassBuilderMethodNameWithArgPrefix: 'cmd');
		nextPut: $.;
		nextPut: cr.
	result
		nextPutAll:
			'	commandBody at: ''id'' ifPresent: [ :v | result aggregateRootId: v ].';
		nextPut: cr.
	result
		nextPutAll: '	result version: cmdContractVersion.';
		nextPut: cr.
	result
		nextPutAll: '	result aggregateRootVersion: cmdVersion.';
		nextPut: cr.
	result
		nextPutAll: '	^ result';
		nextPut: cr.
	^ result contents
]

{ #category : #'code generation' }
EDATestTraitGenerator >> generateTestHelperBuildCommandMethodName [
	^ 'build' , (self toCamelCase: self commandName) , 'SampleCommand'
]

{ #category : #'code generation' }
EDATestTraitGenerator >> generateTestHelperBuildDeleteEventMethod [
	| result eventAttrs cr |
	cr := Character cr.
	eventAttrs := self
		retrieveEventAttributesBut: self class skippedEventAttributes.
	result := WriteStream on: String new.
	result
		nextPutAll:
			(self
				generateTestHelperBuildDeleteEventMethodNameWithId: 'evtId'
				andCommandArg: 'aCommand').
	result nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	| result |';
		nextPut: cr.
	result
		nextPutAll: '	result := ';
		nextPutAll: self appName;
		nextPutAll: 'Test';
		nextPutAll: (self toCamelCase: self eventName);
		nextPutAll: ' new.';
		nextPut: cr.
	result nextPutAll: '  result tenant: aCommand tenant';
	nextPut: cr. 
	result
		nextPutAll: '	result id: aCommand aggregateRootId.';
		nextPut: cr.
	result
		nextPutAll: '	result version: ';
		nextPutAll: self appName;
		nextPutAll: (self toCamelCase: self eventName);
		nextPutAll: ' latestVersion.';
		nextPut: cr.
	result
		nextPutAll: '	result aggregateRootVersion: aCommand aggregateRootVersion + 1.';
		nextPut: cr.
	result
		nextPutAll: '	result timestamp: ''<ANYTHING>''.';
		nextPut: cr.
	result
		nextPutAll: '	result commandId: aCommand commandId.';
		nextPut: cr.
	result
		nextPutAll: '	^ result';
		nextPut: cr.
	^ result contents
]

{ #category : #'code generation' }
EDATestTraitGenerator >> generateTestHelperBuildDeleteEventMethodName [
	^ 'buildDeletedEventWithId:andCommand:'
]

{ #category : #'code generation' }
EDATestTraitGenerator >> generateTestHelperBuildDeleteEventMethodNameWithId: idArg andCommandArg: commandArg [
	^ 'buildDeletedEventWithId: ' , idArg , ' andCommand: ' , commandArg
]

{ #category : #delegated }
EDATestTraitGenerator >> generateTestHelperBuildEventClassMethodNameWithArgPrefix: aString [ 
	| delegate |
	delegate := EDATestSupportGenerator fromExampleFile: self commandFile
				version: self version
				appName: self appName
				aggregate: self aggregate
				commandNameResolver: self commandNameResolver
				andEventNameResolver: self eventNameResolver.
				^ delegate generateTestHelperBuildEventClassMethodNameWithArgPrefix: aString
]

{ #category : #'code generation' }
EDATestTraitGenerator >> generateTestHelperBuildEventFromArbitraryFileMethod [
	| result eventAttrs cr |
	cr := Character cr.
	eventAttrs := self
		retrieveEventAttributesBut: self class skippedEventAttributes.
	result := WriteStream on: String new.
	result
		nextPutAll:
			(self
				generateTestHelperBuildEventFromArbitraryFileMethodNameWithFileArg: 'aFile').
	result nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll:
			'	| eventMessage eventJson eventMeta eventBody evtAttributes evtCommandId evtTenant evtId evtTimestamp |';
		nextPut: cr.
	result
		nextPutAll: '	eventMessage := self readFile: aFile.';
		nextPut: cr.
	result
		nextPutAll: '	eventJson := NeoJSONReader fromString: eventMessage.';
		nextPut: cr.
	result
		nextPutAll: '	eventMeta := eventJson at: #meta.';
		nextPut: cr.
	result
		nextPutAll: '	eventBody := eventJson at: #body.';
		nextPut: cr.
	result
		nextPutAll: '	evtAttributes := Dictionary new.';
		nextPut: cr.
	result
		nextPutAll: '	evtAttributes at: ''version'' put: (eventMeta at: ''version'').';
		nextPut: cr.
	result
		nextPutAll:
			'	evtAttributes at: ''aggregateRootVersion'' put: (eventBody at: ''version'').';
		nextPut: cr.
	result
		nextPutAll: '	evtTenant := eventBody at: ''tenant''.';
		nextPut: cr.
	result
		nextPutAll: '	evtId := eventBody at: ''id''.';
		nextPut: cr.
	result
		nextPutAll:
			'	evtCommandId := eventMeta at: ''correlationId'' ifAbsent: [ ''missing'' ].';
		nextPut: cr.
	result
		nextPutAll: '	evtTimestamp := eventBody at: ''timestamp'' ifAbsent: [ nil ].';
		nextPut: cr.
	result
		nextPutAll:
			'	evtTimestamp ifNil: [ evtTimestamp := eventMeta at: ''timestamp'' ifAbsent: [ nil ] ].';
		nextPut: cr.
	result
		nextPutAll:
			'	evtTimestamp ifNotNil: [ :t | evtAttributes at: ''timestamp'' put: evtTimestamp ].';
		nextPut: cr.
	eventAttrs
		do: [ :attr | 
			result
				nextPutAll: '	eventBody at: ''';
				nextPutAll: attr uncapitalized;
				nextPutAll: ''' ifPresent: [ :v | evtAttributes at: ''';
				nextPutAll: attr uncapitalized;
				nextPutAll: ''' put: v ].';
				nextPut: cr ].
	result
		nextPutAll: '	^ ';
		nextPutAll: self appName;
		nextPutAll: (self toCamelCase: self eventName);
		nextPut: Character space;
		nextPutAll: (self generateTestHelperBuildEventClassMethodNameWithArgPrefix: 'evt');
		nextPut: cr.
	^ result contents
]

{ #category : #'code generation' }
EDATestTraitGenerator >> generateTestHelperBuildEventFromArbitraryFileMethodName [
	^ 'build' , (self toCamelCase: self eventName) , 'EventFromFile:'
]

{ #category : #'code generation' }
EDATestTraitGenerator >> generateTestHelperBuildEventFromArbitraryFileMethodNameWithFileArg: fileArg [
	| evtName |
	evtName := self toCamelCase: self eventName.
	^ 'build' , evtName , 'EventFromFile: ' , fileArg
]

{ #category : #'code generation' }
EDATestTraitGenerator >> generateTestHelperBuildEventMethod [
	| result cr |
	cr := Character cr.
	result := WriteStream on: String new.
	result
		nextPutAll:
			(self
				generateTestHelperBuildEventMethodNameWithId: 'evtId'
				andCommandArg: 'inputCommandId').
	result nextPut: cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	| result |';
		nextPut: cr.
	result
		nextPutAll: '	result := ';
		nextPutAll: self appName;
		nextPutAll: 'Test';
		nextPutAll: (self toCamelCase: self eventName);
		nextPutAll: ' fromEvent: (';
		nextPutAll: self generateTestHelperBuildEventFromArbitraryFileMethodName;
		nextPutAll: ' self ';
		nextPutAll: self generateReadEventFromFileTestHelperMethodName;
		nextPutAll: ')';
		nextPut: $.;
		nextPut: cr.
	result
		nextPutAll: '	result id: evtId.';
		nextPut: cr.
	result
		nextPutAll: '	result commandId: inputCommandId.';
		nextPut: cr.
	result
		nextPutAll: '	^ result';
		nextPut: cr.
	^ result contents
]

{ #category : #'code generation' }
EDATestTraitGenerator >> generateTestHelperBuildEventMethodName [
	^ 'build' , (self toCamelCase: self eventName) , 'SampleEventWithId:andCommandId:'
]

{ #category : #'code generation' }
EDATestTraitGenerator >> generateTestHelperBuildEventMethodNameFromArbitraryFileWithFileArg: fileArg [
	| evtName |
	evtName := self toCamelCase: self eventName.
	^ 'build' , evtName , 'EventFromFile: ' , fileArg
]

{ #category : #'code generation' }
EDATestTraitGenerator >> generateTestHelperBuildEventMethodNameWithId: idArg andCommandArg: commandArg [
	| evtName |
	evtName := self toCamelCase: self eventName.
	^ 'build' , evtName , 'SampleEventWithId: ' , idArg , ' andCommandId: ' , commandArg
]

{ #category : #'code generation' }
EDATestTraitGenerator >> retrieveTestHelperTraitName [
	^ self appName , 'T' , (self toCamelCase: self aggregate ) , 'TestHelper'
]
