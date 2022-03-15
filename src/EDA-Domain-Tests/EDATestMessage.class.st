Class {
	#name : #EDATestMessage,
	#superclass : #Object,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#instVars : [
		'message',
		'commandOrEventClass'
	],
	#category : #'EDA-Domain-Tests'
}

{ #category : #'instance creation' }
EDATestMessage class >> checkValidClass: aClass [.
	self subclassResponsibility
]

{ #category : #'helper - file readers' }
EDATestMessage class >> commandSampleFilesPath [
	^ FileSystem disk workingDirectory / 'contracts' / 'Core' / 'commands'
]

{ #category : #'helper - file readers' }
EDATestMessage class >> defaultSampleFileNameFor: aCommandOrEventClass [
	| classNamePrefixRemoved |
	
	"e.g. <classPrefix>CommandoreventNameUpperCamelCase -> commandorevent.name.upper.camel.case.example.json"
	"EDATLanguageHelper class >> removePrefix:from:
	EDASourceCodeHelperStub >> separateCamelCase:with:"
	classNamePrefixRemoved :=  ('^' , aCommandOrEventClass classPrefix copyReplaceAll: ':' with: '\:') asRegexIgnoringCase copy: aCommandOrEventClass name replacingMatchesWith: ''.
	^ ((classNamePrefixRemoved copyWithRegex: '[A-Z]' matchesTranslatedUsing: [ :each | '.' , each asLowercase  ]) allButFirst) , '.example.json'.
]

{ #category : #helper }
EDATestMessage class >> domainCustomizationOfBodyDict: bodyJsonDict [
	(self domainToMessageAttributesMap at: #body)
		keysAndValuesDo: [ :domainAttributeName :messageAttributeName |
			bodyJsonDict changeKey: messageAttributeName to: domainAttributeName ]
]

{ #category : #helper }
EDATestMessage class >> domainCustomizationOfMetaDict: metaJsonDict [
	(self domainToMessageAttributesMap at: #meta)
		keysAndValuesDo: [ :domainAttributeName :messageAttributeName |
			metaJsonDict changeKey: messageAttributeName to: domainAttributeName
			 ]
]

{ #category : #helper }
EDATestMessage class >> domainTemplateOfBodyDict: bodyJsonDict [

	bodyJsonDict associationsDo: [ :assoc |
		| messageAttributeName domainAttributeName |
		messageAttributeName := assoc key asString.
		domainAttributeName := ((self domainToMessageAttributesMap at: #body) keyAtValue: messageAttributeName ifAbsent: messageAttributeName) asString.
		self generatedAttributesWhenPublishing
			detect: [ :generatedAttr | domainAttributeName = generatedAttr ]
			ifNone: [ assoc value: ('{{' ,  domainAttributeName , '}}') ]
		 ]
	
"	(self domainToMessageAttributesMap at: #meta)
		keysAndValuesDo: [ :domainAttributeName :messageAttributeName |
			metaJsonDict changeKey: messageAttributeName to: domainAttributeName
			 ]"
]

{ #category : #helper }
EDATestMessage class >> domainTemplateOfMetaDict: metaJsonDict [

	metaJsonDict associationsDo: [ :assoc |
		| messageAttributeName domainAttributeName |
		messageAttributeName := assoc key asString.
		domainAttributeName := ((self domainToMessageAttributesMap at: #meta) keyAtValue: messageAttributeName ifAbsent: messageAttributeName) asString.
		self generatedAttributesWhenPublishing
			detect: [ :generatedAttr | domainAttributeName = generatedAttr ]
			ifNone: [ assoc value: ('{{' ,  domainAttributeName , '}}') ]
		 ]
	
"	(self domainToMessageAttributesMap at: #meta)
		keysAndValuesDo: [ :domainAttributeName :messageAttributeName |
			metaJsonDict changeKey: messageAttributeName to: domainAttributeName
			 ]"
]

{ #category : #helper }
EDATestMessage class >> domainToMessageAttributesMap [
	self subclassResponsibility
]

{ #category : #'helper - file readers' }
EDATestMessage class >> eventSampleFilesPath [
	^ FileSystem disk workingDirectory / 'contracts' / 'Core' / 'events'
]

{ #category : #helper }
EDATestMessage class >> fillBodyDict: bodyJsonDict with: aCommandOrEvent [
	bodyJsonDict associationsDo: [ :assoc |
		| messageAttributeName domainAttributeName |
		messageAttributeName := assoc key asString.
		domainAttributeName := ((self domainToMessageAttributesMap at: #body) keyAtValue: messageAttributeName ifAbsent: messageAttributeName) asString.
		(self nonDomainAttributesFor: aCommandOrEvent)
			detect: [ :generatedAttr | domainAttributeName = generatedAttr ]
			ifNone: [ assoc value: (domainAttributeName asSymbol value: aCommandOrEvent) ] ]
]

{ #category : #helper }
EDATestMessage class >> fillMetaDict: metaJsonDict with: aCommandOrEvent [
	metaJsonDict associationsDo: [ :assoc |
		| messageAttributeName domainAttributeName |
		messageAttributeName := assoc key asString.
		domainAttributeName := ((self domainToMessageAttributesMap at: #meta) keyAtValue: messageAttributeName ifAbsent: messageAttributeName) asString.
		(self nonDomainAttributesFor: aCommandOrEvent)
			detect: [ :generatedAttr | domainAttributeName = generatedAttr ]
			ifNone: [ assoc value: (domainAttributeName asSymbol value: aCommandOrEvent) ]
		 ]
]

{ #category : #'instance creation' }
EDATestMessage class >> forClass: aCommandOrEventOrAggregateClass [
	" Constructor for Test Message of command, event or deleteAggregateCommand"
	| testMessage |
	self checkValidClass: aCommandOrEventOrAggregateClass.
	testMessage := self new.
	testMessage message: (self readSampleFileFor: aCommandOrEventOrAggregateClass).
	testMessage commandOrEventClass: aCommandOrEventOrAggregateClass.
	^ testMessage
	


]

{ #category : #'instance creation' }
EDATestMessage class >> fromInstance: aCommandOrEvent [
	" Constructor for Test Message of command, event or deleteAggregateCommand from a command or event instance"
	| commandOrEventOrAggregateClass testMessage |
	commandOrEventOrAggregateClass := self retrieveCommandOrEventOrAggregateClassFor: aCommandOrEvent.
	testMessage := self forClass: commandOrEventOrAggregateClass.
	testMessage message: (testMessage asJsonMessageFilledWith: aCommandOrEvent).
	^ testMessage
	


]

{ #category : #helper }
EDATestMessage class >> nonDomainAttributesFor: aCommandOrEvent [
"these attributes do not correspond to the domain"
	^ aCommandOrEvent class templateAttributesNotRequired
]

{ #category : #'helper - file readers' }
EDATestMessage class >> readFile: aFile [
	| fileStream result |
	fileStream := aFile readStream.
	result := fileStream contents.
	fileStream close.
	^ result
]

{ #category : #'helper - file readers' }
EDATestMessage class >> readSampleFileFor: aCommandOrEventClass [
	^ self readFile: ((aCommandOrEventClass sampleFilesPathForTestMessage: self) / ('v' , aCommandOrEventClass latestVersion asString) / (aCommandOrEventClass sampleFileNameForTestMessage: self))
]

{ #category : #helper }
EDATestMessage class >> retrieveCommandOrEventOrAggregateClassFor: aCommandOrEvent [
	^ aCommandOrEvent class
	


]

{ #category : #accessing }
EDATestMessage >> asDictionary [
	^ NeoJSONReader fromString: message
]

{ #category : #accessing }
EDATestMessage >> asDomainJsonDictionary [
	| jsonDictionary metaJsonDict bodyJsonDict |
	jsonDictionary := self asDictionary.
	metaJsonDict := jsonDictionary at: #meta.
	bodyJsonDict := jsonDictionary at: #body.
	self class domainCustomizationOfMetaDict: metaJsonDict.
	self class domainCustomizationOfBodyDict: bodyJsonDict.
	^ jsonDictionary
]

{ #category : #accessing }
EDATestMessage >> asJsonMessage [
	^ message copy
]

{ #category : #accessing }
EDATestMessage >> asJsonMessageFilledWith: aCommandOrEvent [
	| domainJsonDictionary metaDomainJsonDict bodyDomainJsonDict |
	domainJsonDictionary := self asDictionary.
	metaDomainJsonDict := domainJsonDictionary at: #meta.
	self class fillMetaDict: metaDomainJsonDict with: aCommandOrEvent.
	bodyDomainJsonDict := domainJsonDictionary at: #body.
	self class fillBodyDict: bodyDomainJsonDict with: aCommandOrEvent.
	^ String streamContents: [ :s |
		| jsonWriter |
		jsonWriter := NeoJSONWriter on: s.
		jsonWriter prettyPrint: true.
		jsonWriter
			for: DateAndTime
			customDo: [ :mapping | mapping encoder: [ :tmst | tmst asUTC rounded printString ] ].
		"self customJsonMappingsFor: jsonWriter."
		jsonWriter nextPut: domainJsonDictionary ]
]

{ #category : #'helper - inst var checking' }
EDATestMessage >> checkInstVars [
	self newInstVarNeeded
		ifNotEmpty: [ :instvars | 
			self
				logErrorMessage: (self instVarsNeededMessage value: instvars greaseString value: commandOrEventClass name)
				andThrow: self instVarsNeededException ]
	"	Automatic creation
	newInstVarsNeeded 
		do: [ :instVarName | 
			self addInstVarNamed: instVarName greaseString.
			formCreatedTestEvt
				instVarNamed: instVarName greaseString
				put: (theAttrs at: instVarName)
				ifAbsent: [ self logDebugMessage: 'No instVar created' ] ]."
]

{ #category : #'helper - inst var checking' }
EDATestMessage >> checkVersion [
	| templateLatestVersion instanceLatestVersion |
	templateLatestVersion := self asDomainJsonDictionary at: #meta at: #version.
	instanceLatestVersion := commandOrEventClass latestVersion.
	(templateLatestVersion = instanceLatestVersion)
		ifFalse: [ self logErrorMessage: 'Different latest version of template example [' , templateLatestVersion greaseString , ']  and instance [' , instanceLatestVersion greaseString , '] of ' , commandOrEventClass className , '. Check template and #latestVersion.' andThrow: EDADifferentLatestVersion ]
		
]

{ #category : #'helper - inst var checking' }
EDATestMessage >> comandOrEventInstVars [
	^ commandOrEventClass allInstVarNames collect: [ :each | each asSymbol ]
]

{ #category : #accessing }
EDATestMessage >> commandOrEventClass: anObject [
	commandOrEventClass := anObject
]

{ #category : #accessing }
EDATestMessage >> domainAttributes [
	| domainJsonDict |
	domainJsonDict := self asDomainJsonDictionary.
	^ ((domainJsonDict at: #meta) | (domainJsonDict at: #body))
]

{ #category : #accessing }
EDATestMessage >> domainJsonTemplate [
	| jsonDictionary metaJsonDict bodyJsonDict domainTemplateJson |
	jsonDictionary := self asDictionary.
	metaJsonDict := jsonDictionary at: #meta.
	self class domainTemplateOfMetaDict: metaJsonDict.
	bodyJsonDict := jsonDictionary at: #body.
	self class domainTemplateOfBodyDict: bodyJsonDict.
	domainTemplateJson := NeoJSONWriter toStringPretty: jsonDictionary.
	domainTemplateJson := domainTemplateJson copyReplaceAll: '"{{' with: '{{'.
	domainTemplateJson := domainTemplateJson copyReplaceAll: '}}"' with: '}}'.
	^ domainTemplateJson
]

{ #category : #'helper - inst var checking' }
EDATestMessage >> instVarsNeededException [
	self subclassResponsibility
]

{ #category : #'helper - inst var checking' }
EDATestMessage >> instVarsNeededMessage [
	self subclassResponsibility
]

{ #category : #accessing }
EDATestMessage >> message: aJsonMessage [
	message := aJsonMessage
]

{ #category : #'instance creation' }
EDATestMessage >> newInstVarNeeded [
	^ self templateAttributes \ commandOrEventClass templateAttributesNotRequired \ self comandOrEventInstVars.
]

{ #category : #'instance creation' }
EDATestMessage >> templateAttributes [
	^ self domainAttributes keys collect: [ :each | each asSymbol ]
]
