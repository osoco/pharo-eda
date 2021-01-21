"
This class generates (and compiles) all Command-related classes.

To use it for a new command (json example file under commands/BBVA-ATS/v1/ folder), proceed as follows:

| edaApplicationPrefix jsonFile generator aggregate |
edaApplicationPrefix := 'ATS'.
jsonFile := FileSystem workingDirectory / 'contracts' / 'BBVA-ATS' / 'v1' / 'commands' / 'update.round.example.json'.
aggregate := 'Round'.
generator := (EDAGenerator fromExampleFile: jsonFile appName: edaApplicationPrefix aggregate: aggregate).
generator generateAll
"
Class {
	#name : #EDAGenerator,
	#superclass : #AbstractEDAGenerator,
	#instVars : [
		'eventNameResolver',
		'commandNameResolver'
	],
	#category : 'EDA-Tools'
}

{ #category : #'instance creation' }
EDAGenerator class >> fromExampleFile: aFile version: version appName: appName aggregate: aggregate [
	^ self
		fromExampleFile: aFile
		version: version
		appName: appName
		aggregate: aggregate
		commandNameResolver: DefaultEnglishCommandNameResolver new
		andEventNameResolver: DefaultEnglishEventNameResolver new
]

{ #category : #'instance creation' }
EDAGenerator class >> fromExampleFile: aFile version: version appName: appName aggregate: aggregate commandNameResolver: aCommandNameResolver andEventNameResolver: anEventNameResolver [
	| result eventRaw |
	result := self new
		commandFile: aFile;
		appName: appName;
		aggregate: aggregate;
		version: version.
	result commandNameResolver: aCommandNameResolver.
	result eventNameResolver: anEventNameResolver.
	result commandRaw: result readCommandExampleFile.
	result commandJson: (NeoJSONReader fromString: result commandRaw).
	result
		commandName:
			(result
				commandNameFor: ((result commandJson at: #meta) at: #type)
				usingCommandNameResolver: aCommandNameResolver).
	result
		eventName:
			(result
				eventNameFor: result commandName
				usingEventNameResolver: anEventNameResolver).
	result
		eventFile:
			aFile parent parent parent / 'events' / aFile parent basename
				/ (result upcasedToDotSeparated: result eventName , '.example.json').
				eventRaw := result readEventExampleFile.
				eventRaw ifNil: [ result := nil ] ifNotNil: [ :o | result eventRaw: o.
	result eventJson: (NeoJSONReader fromString: o) ].
	^ result
]

{ #category : #sorting }
EDAGenerator class >> shouldRunAfter: anotherGenerator [
	^ false
]

{ #category : #api }
EDAGenerator >> buildMessage [
	^ 'Generating code based on contracts for ' , self description , ' (version: ' , self version greaseString , ')'
]

{ #category : #accessing }
EDAGenerator >> commandNameResolver [
	^ commandNameResolver
]

{ #category : #accessing }
EDAGenerator >> commandNameResolver: aResolver [
	commandNameResolver := aResolver
]

{ #category : #protected }
EDAGenerator >> description [
	self subclassResponsibility
]

{ #category : #protected }
EDAGenerator >> doGenerate [
	self subclassResponsibility
]

{ #category : #accessing }
EDAGenerator >> eventNameResolver [
	^ eventNameResolver
]

{ #category : #accessing }
EDAGenerator >> eventNameResolver: aResolver [
	eventNameResolver := aResolver
]

{ #category : #'code generation' }
EDAGenerator >> expectedEventFromFile [
	| evtJson id body |
	evtJson := NeoJSONReader fromString: self readEventExampleFile.
	body := evtJson at: #body.
	id := body at: #id ifAbsent: [ nil ].
	body at: #id put: '<ANYTHING>'.
	self retrieveAggregateIdNames
		do: [ :aux | 
			| var |
			var := body at: aux asSymbol ifAbsent: [ nil ].
			var ifNotNil: [ body at: aux asSymbol put: '<ANYTHING>' ] ].
	^ String
		streamContents: [ :stream | 
			(NeoJSONWriter on: stream)
				for: DateAndTime customDo: [ :mapping | mapping encoder: [ :dateAndTime | '<ANYTHING>' ] ];
				nextPut: evtJson ]
]

{ #category : #api }
EDAGenerator >> generate [
	self logDebugMessage: '** ' , self buildMessage.
	self doGenerate
]

{ #category : #'code generation' }
EDAGenerator >> generateAccessorsFor: cls attributes: attributes [
	| result |
	result := Dictionary new.
	(attributes select: [ :attr | cls instVarNames anySatisfy: [ :a | a = attr ] ])
		do: [ :attr | 
			result at: (attr , ':') asSymbol put: (self generateSetterFor: attr).
			result at: attr asSymbol put: (self generateGetterFor: attr) ].
	^ result
]

{ #category : #'code generation' }
EDAGenerator >> generateAttributesEqualsMethodFor: attributes [
	| result |
	result := WriteStream on: String new.
	result
		nextPutAll: 'semanticEquals: anInstance';
		nextPut: Character cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	^ self class = anInstance class and: [ self id = anInstance id and: [';
		nextPutAll: (self generateEqualsAndBlockRecursively: attributes);
		nextPutAll: '] ].'.
	^ result contents
]

{ #category : #'code generation' }
EDAGenerator >> generateAttributesHashMethodFor: attributes [
	| result |
	result := WriteStream with: String new.
	result
		nextPutAll: 'semanticHash';
		nextPut: Character cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '    ^ self class greaseString hash bitXor:( self id hash bitXor: (';
		nextPutAll: (self generateHashAndBlockRecursively: attributes);
		nextPut: $);
		nextPut: $).
	^ result contents
]

{ #category : #'code generation' }
EDAGenerator >> generateEqualsAndBlockRecursively: attributes [
	| result attribute |
	attributes size > 0
		ifTrue: [ attribute := attributes first.
			result := ' self ' , attribute , ' = anInstance ' , attribute.
			attributes size > 1
				ifTrue: [ result := result , ' and: [ ' , (self generateEqualsAndBlockRecursively: attributes allButFirst) , ' ]' ] ].
	^ result
]

{ #category : #'code generation' }
EDAGenerator >> generateEqualsMethodFor: attributes [
	"^ self generateNoAttributesEqualsMethodFor: attributes"
	^ self generateAttributesEqualsMethodFor: attributes.
]

{ #category : #'code generation' }
EDAGenerator >> generateGetterFor: attribute [
	^ attribute
		,
			'
' , self generateSignature , '	^ ' , attribute
]

{ #category : #'code generation' }
EDAGenerator >> generateHashAndBlockRecursively: attributes [
	| result |
	result := WriteStream with: String new.
	attributes isEmpty
		ifFalse: [ | wrap attribute |
			attribute := attributes first.
			wrap := attributes size > 1.
			wrap
				ifTrue: [ result nextPut: $( ].
			result
				nextPutAll: 'self ';
				nextPutAll: attribute;
				nextPutAll: ' hash'.
			attributes size > 1
				ifTrue: [ result
						nextPutAll: ' bitXor: ';
						nextPutAll: (self generateHashAndBlockRecursively: attributes allButFirst) ].
			wrap
				ifTrue: [ result nextPut: $) ] ].
	^ result contents
]

{ #category : #'code generation' }
EDAGenerator >> generateHashMethodFor: attributes [
   "^ self generateNoAttributesHashMethodFor: attributes"
	^ self generateAttributesHashMethodFor: attributes
]

{ #category : #'code generation' }
EDAGenerator >> generateNoAttributesEqualsMethodFor: attributes [
	| result |
	result := WriteStream on: String new.
	result
		nextPutAll: '= anInstance';
		nextPut: Character cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '	^ super = anInstance'.
	^ result contents
]

{ #category : #'code generation' }
EDAGenerator >> generateNoAttributesHashMethodFor: attributes [
	| result |
	result := WriteStream with: String new.
	result
		nextPutAll: 'hash';
		nextPut: Character cr.
	result nextPutAll: self generateSignature.
	result
		nextPutAll: '    ^ super hash'.
	^ result contents
]

{ #category : #'code generation' }
EDAGenerator >> generateSetterFor: attribute [
	^ attribute
		,
			': newValue
',	self generateSignature, '	', attribute , ' := newValue'
]
