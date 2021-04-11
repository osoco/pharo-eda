Trait {
	#name : #EDATSourceCodeHelper,
	#traits : 'EDATLanguageHelper',
	#category : #'EDA-Traits'
}

{ #category : #helper }
EDATSourceCodeHelper classSide >> allAttributesOf: cls [
	| result |
	result := OrderedCollection new.
	result addAll: cls instVarNames.
	^ result
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> allAttributesOf: cls including: attributes [
	| result |
	result := OrderedCollection withAll: attributes.
	result addAll: cls instVarNames.
	^ (Set withAll: result) asOrderedCollection 
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> asPharoSourceCode: anAttributeValue [
	| result cr |
	cr := String with: Character cr.
	(anAttributeValue isKindOf: Array)
		ifTrue: [ result := cr , '#('.
			anAttributeValue
				keysAndValuesDo: [ :i :item | 
					i > 1
						ifTrue: [ result := result , '.' ].
					result := result , (self asPharoSourceCode: item) , cr ].
			result := result , ') asOrderedCollection' ]
		ifFalse: [ (anAttributeValue isKindOf: Dictionary)
				ifTrue: [ result := cr , 'Dictionary newFrom: {'.
					anAttributeValue keys
						keysAndValuesDo: [ :i :item | 
							i > 1
								ifTrue: [ result := result , '.' ].
							result := result , cr , (self asPharoSourceCode: item) , ' -> '
								, (self asPharoSourceCode: (anAttributeValue at: item)) , cr ].
					result := result , '}' , cr ]
				ifFalse: [ result := (anAttributeValue isKindOf: String)
						ifTrue: [ $' greaseString , anAttributeValue , $' greaseString ]
						ifFalse: [ anAttributeValue greaseString ] ] ].
	^ result
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> camelCaseToDotSeparated: aString [
   ^ self separateCamelCase: aString with: '.'
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> classExists: className [
	^ Smalltalk hasClassNamed: className asSymbol
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> commandNameFor: anEventName [
	^ self commandNameFor: anEventName withSeparator: '.'
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> commandNameFor: aCommandName usingCommandNameResolver: aCommandNameResolver [
	^ aCommandNameResolver resolve: aCommandName
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> commandNameFor: anEventName withSeparator: separator [
	| result aux |
	result := nil.
	aux := anEventName allRegexMatches: '([^' , separator , ']*)'.
	aux size > 2
		ifTrue: [ | past rest present |
			rest := aux allButLast allButLast.
			past := aux allButLast last.
			present := self verbInPresentTense: past.
			result := ''.
			rest
				keysAndValuesDo: [ :i :noun | 
					i < rest size
						ifTrue: [ result := result , separator ].
					result := result , noun ].
			result := present , separator , result ].
	^ result
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> concatenateCollection: aCollection with: aSeparator [
	| txt |
	txt := ''.
	aCollection
		keysAndValuesDo: [ :i :item | 
			i > 1
				ifTrue: [ txt := txt , aSeparator ].
			txt := txt , item ].
	^ txt
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> cr [
	^ Character cr
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> dotSeparatedToCamelCase: aString [
	^ self toCamelCase: aString usingSeparator: '\.'

]

{ #category : #helper }
EDATSourceCodeHelper classSide >> eventNameFor: aCommandName usingEventNameResolver: anEventNameResolver [
	^ anEventNameResolver resolve: aCommandName
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> generateSignature [
	| fromCommand file |
	self flag: #TODO. "Disabled since it generates conflicts in git, and checkBytecodeHash:sourceCode:inClass: is not useful for figuring out if the method actually changes."
	fromCommand := self commandFile isNotNil.
	file := fromCommand
		ifTrue: [ self commandFile ]
		ifFalse: [ self eventFile ].
	"^ '	""Generated by ' , self class greaseString , '>>' , thisContext sender selector , ' for ' , self aggregate , ' aggregate from file ' , file fullPath basename , ' at '
		, DateAndTime now asUTC greaseString , ' ""' , (String with: Character cr)"
	^ String with: Character cr
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> generatedProtocolFor: aNumber [
	| result |
	result := (aNumber ifNil: [ 'generated' ] ifNotNil: [ 'generated-v' , aNumber greaseString ]) asSymbol.
	^ result
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> normalize: aString [
	^ (self replace: '\W' with: '_' inString: aString trimmed) asLowercase
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> remove: prefix fromBeginningOf: aString [
	| result |
	result := (aString beginsWith: prefix) ifTrue: [ aString copyReplaceFrom: 1 to: prefix size with: '' ] ifFalse: [ aString ].
	^ result
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> removeClassLiteralFromMetaClassName: aString [
	^ ' class$' asRegexIgnoringCase copy: aString replacingMatchesWith: ''
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> removeSuffix: suffix fromFileName: aFile [
	^ aFile basename copyWithRegex: (suffix copyWithRegex: '\.' matchesReplacedWith: '\.') , '$' matchesReplacedWith: ''
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> replace: match with: replacement inString: aString [
	^ match asRegexIgnoringCase copy: aString replacingMatchesWith: replacement
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> retrieveAggregateFromAggregateKey: json [
	| result aux |
	aux := (json at: #meta) at: #aggregate ifAbsent: [ nil ].
	result := aux ifNil: [ nil ] ifNotNil: [ :arg | aux asCamelCase ].
	^ result
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> retrieveAggregateFromCommandType: json [
	| result type aux |
	result := nil.
	aux := (json at: #meta) at: #type ifAbsent: [ nil ].
	aux 
		ifNotNil: [ :arg | 
			type := aux allRegexMatches: '([^_]*)'.
			type
				do: [ :word | 
					(self isAggregate: word)
						ifTrue: [ result := self toCamelCase: word asCamelCase ] ] ].
	^ result
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> separateCamelCase: aString with: aSeparator [
   ^ (aString copyWithRegex: '[A-Z]' matchesTranslatedUsing: [ :each | aSeparator , each asLowercase  ]) allButFirst 
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> toCamelCase: aString [
	^ self underscoreSeparatedToCamelCase: aString asCamelCase 
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> toCamelCase: aString usingSeparator: separator [
	| aux result |
	aux := separator asRegexIgnoringCase copy: aString replacingMatchesWith: ' '.
	result := aux = aux asUppercase 
		ifTrue: [ aux asLowercase asCamelCase ]
		ifFalse: [ aux asCamelCase  ].
	^ result
]

{ #category : #helper }
EDATSourceCodeHelper classSide >> underscoreSeparatedToCamelCase: aString [
	^ self toCamelCase: aString usingSeparator: '_'

]

{ #category : #helper }
EDATSourceCodeHelper classSide >> upcasedToDotSeparated: aString [
	| aux |
	aux := '_' asRegexIgnoringCase copy: aString replacingMatchesWith: '.'.
	^ aux asLowercase
]

{ #category : #helper }
EDATSourceCodeHelper >> allAttributesOf: cls [
	^ self class allAttributesOf: cls
]

{ #category : #helper }
EDATSourceCodeHelper >> allAttributesOf: cls including: attributes [
	^ self class allAttributesOf: cls including: attributes
]

{ #category : #helper }
EDATSourceCodeHelper >> asPharoSourceCode: anAttributeValue [
	^ self class asPharoSourceCode: anAttributeValue
]

{ #category : #helper }
EDATSourceCodeHelper >> camelCaseToDotSeparated: aString [
	^ self class camelCaseToDotSeparated: aString
]

{ #category : #compilation }
EDATSourceCodeHelper >> checkBytecodeHash: methodName sourceCode: method inClass: aClass [
	| existingClass existingMethod result |
	self flag: #TODO. "Two methods with different comments generate different bytecodes for some reason"
	existingClass := (self class environment at: aClass name asSymbol ifAbsent: nil).
	existingMethod := existingClass ifNil: [ nil ] ifNotNil: [ :c | c methodDictionary at: methodName asSymbol ifAbsent: [ nil ] ].
	result := existingMethod isNotNil.
	result
		ifTrue: [ | tempClass generatedMethod |
			tempClass := Object
				subclass: (aClass greaseString , 'Temp') asSymbol
				instanceVariableNames: ''
				classVariableNames: ''
				package: 'EDA-Tools-Temp'.
			tempClass compile: method classified: #temp.
			generatedMethod := tempClass methodDictionary at: methodName asSymbol.
			result := generatedMethod bytecodesHash = existingMethod bytecodesHash.
			tempClass removeFromSystem ].
	^ result
]

{ #category : #helper }
EDATSourceCodeHelper >> classExists: className [
	^ self class classExists: className
]

{ #category : #helper }
EDATSourceCodeHelper >> commandNameFor: anEventName [
	^ self class commandNameFor: anEventName
]

{ #category : #helper }
EDATSourceCodeHelper >> commandNameFor: aCommandName usingCommandNameResolver: aCommandNameResolver [
	^ self class commandNameFor: aCommandName usingCommandNameResolver: aCommandNameResolver
]

{ #category : #helper }
EDATSourceCodeHelper >> commandNameFor: anEventName withSeparator: separator [
	^ self class commandNameFor: anEventName withSeparator: separator
]

{ #category : #compilation }
EDATSourceCodeHelper >> compile: methodName sourceCode: method inClass: aClass classifiedAs: protocol [
	| compile |
	self flag: #TODO. "Disabled checkBytecodeHash:sourceCode:inClass: since it doesn't help figuring out if a method changes only by a signature timestamp"
	compile := (self isMethod: methodName markedAsDisableRegenerationInClass: aClass) not.
	"compile := compile
		ifTrue: [ (self checkBytecodeHash: methodName sourceCode: method inClass: aClass) not ]
		ifFalse: [ false ]."
	compile
		ifTrue: [ | existingMethod |
			existingMethod := aClass methodDictionary at: methodName asSymbol ifAbsent: [ nil ].
			existingMethod ifNil: [ compile := true ] ifNotNil: [ :m | compile := m protocol greaseString beginsWithSubCollection: 'generated' ] ].
	compile
		ifTrue: [ aClass compile: method classified: protocol ]
]

{ #category : #compilation }
EDATSourceCodeHelper >> compileIfDoesNotExist: methodName sourceCode: method inClass: aClass classifiedAs: protocol [
	aClass methodDictionary
		at: methodName asSymbol
		ifAbsent: [ self
				compile: methodName
				sourceCode: method
				inClass: aClass
				classifiedAs: protocol ]
]

{ #category : #helper }
EDATSourceCodeHelper >> concatenateCollection: aCollection with: aSeparator [
	^ self class concatenateCollection: aCollection with: aSeparator
]

{ #category : #'compilation-support' }
EDATSourceCodeHelper >> containsAnyDisableRegenerationMethod: aClass [
	^ (self retrieveDisableRegenerationPragmas: aClass) isNotEmpty
]

{ #category : #helper }
EDATSourceCodeHelper >> cr [
	^ self class cr
]

{ #category : #helper }
EDATSourceCodeHelper >> dotSeparatedToCamelCase: aString [
	^ self class dotSeparatedToCamelCase: aString
]

{ #category : #helper }
EDATSourceCodeHelper >> eventNameFor: aCommandName usingEventNameResolver: anEventNameResolver [
	^ self class eventNameFor: aCommandName usingEventNameResolver: anEventNameResolver
]

{ #category : #helper }
EDATSourceCodeHelper >> generateSignature [
	^ self class generateSignature
]

{ #category : #helper }
EDATSourceCodeHelper >> generatedProtocolFor: aNumber [
	^ self class generatedProtocolFor: aNumber
]

{ #category : #'compilation-support' }
EDATSourceCodeHelper >> isMethod: aMethodName markedAsDisableRegenerationInClass: aClass [
	^ (aClass methodDictionary at: aMethodName asSymbol ifAbsent: [ ^ false ]) hasPragmaNamed: 'disable_regeneration'
]

{ #category : #helper }
EDATSourceCodeHelper >> normalize: aString [
	^ self class normalize: aString
]

{ #category : #helper }
EDATSourceCodeHelper >> remove: prefix fromBeginningOf: aString [
	^ self class remove: prefix fromBeginningOf: aString
]

{ #category : #helper }
EDATSourceCodeHelper >> removeClassLiteralFromMetaClassName: aString [
	^ self class removeClassLiteralFromMetaClassName: aString
]

{ #category : #helper }
EDATSourceCodeHelper >> removeSuffix: suffix fromFileName: aFile [
	^ self class removeSuffix: suffix fromFileName: aFile
]

{ #category : #helper }
EDATSourceCodeHelper >> replace: match with: replacement inString: aString [
	^ self class replace: match with: replacement inString: aString
]

{ #category : #helper }
EDATSourceCodeHelper >> retrieveAggregateFromAggregateKey: json [
	^ self class retrieveAggregateFromAggregateKey: json
]

{ #category : #helper }
EDATSourceCodeHelper >> retrieveAggregateFromCommandType: json [
	^ self class retrieveAggregateFromCommandType: json
]

{ #category : #'compilation-support' }
EDATSourceCodeHelper >> retrieveDisableRegenerationPragmas: aClass [
	^ self retrieveMethodsInClass: aClass withPragma: 'disable_regeneration'

]

{ #category : #'compilation-support' }
EDATSourceCodeHelper >> retrieveMethodsInClass: aClass withPragma: aPragma [
	(self classExists: aClass asSymbol)
		ifTrue: [ ^ (Pragma
				allNamed: aPragma
				in: (self class environment at: aClass asSymbol)) collect: [ :pragma | pragma method ] ]
		ifFalse: [ ^ #() ]
]

{ #category : #helper }
EDATSourceCodeHelper >> separateCamelCase: aString with: aSeparator [
	^ self class separateCamelCase: aString with: aSeparator
]

{ #category : #helper }
EDATSourceCodeHelper >> toCamelCase: aString [
	^ self class toCamelCase: aString
]

{ #category : #helper }
EDATSourceCodeHelper >> toCamelCase: aString usingSeparator: separator [
	^ self class toCamelCase: aString usingSeparator: separator
]

{ #category : #helper }
EDATSourceCodeHelper >> underscoreSeparatedToCamelCase: aString [
	^ self class underscoreSeparatedToCamelCase: aString
]

{ #category : #helper }
EDATSourceCodeHelper >> upcasedToDotSeparated: aString [
	^ self class upcasedToDotSeparated: aString
]