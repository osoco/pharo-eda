Class {
	#name : #AbstractEDAGenerator,
	#superclass : #Object,
	#traits : 'EDATSourceCodeHelper + EDATCheckerHelper + EDATLogging',
	#classTraits : 'EDATSourceCodeHelper classTrait + EDATCheckerHelper classTrait + EDATLogging classTrait',
	#instVars : [
		'commandName',
		'commandRaw',
		'commandJson',
		'commandFile',
		'appName',
		'aggregate',
		'eventJson',
		'eventRaw',
		'eventFile',
		'eventName',
		'version'
	],
	#category : 'EDA-Tools'
}

{ #category : #customization }
AbstractEDAGenerator class >> skippedAggregateAttributes [
	^ #('tenant' 'id' 'version' 'scopeContext' 'scopeKey' 'agent')
]

{ #category : #customization }
AbstractEDAGenerator class >> skippedCommandAttributes [
	^ #('applicationKey' 'commandId' 'aggregateRootId' 'originalTimestamp' 'aggregateRootVersion' 'version' 'id' 'scopeContext' 'scopeKey' 'tenant' 'agent' 'correlationId')
]

{ #category : #customization }
AbstractEDAGenerator class >> skippedEventAttributes [
	^ #('id' 'commandId' 'aggregateRootClass' 'timestamp' 'aggregateRootVersion' 'version' 'scopeContext' 'scopeKey' 'tenant' 'agent')
]

{ #category : #accessing }
AbstractEDAGenerator >> aggregate [
	^ aggregate
]

{ #category : #accessing }
AbstractEDAGenerator >> aggregate: aString [
	aggregate := aString
]

{ #category : #helper }
AbstractEDAGenerator >> aggregateClass [
	^ (self appName , (self underscoreSeparatedToCamelCase: self aggregate))
]

{ #category : #accessing }
AbstractEDAGenerator >> appName [
	^ appName
]

{ #category : #accessing }
AbstractEDAGenerator >> appName: aString [
	appName := aString
]

{ #category : #accessing }
AbstractEDAGenerator >> commandContainsAttribute: attr [
	| body |
	body := commandJson at: #body.
	^ body at: attr ifPresent: [ true ] ifAbsent: [ false ]
]

{ #category : #accessing }
AbstractEDAGenerator >> commandFile [
	^ commandFile
]

{ #category : #accessing }
AbstractEDAGenerator >> commandFile: aString [
	commandFile := aString
]

{ #category : #accessing }
AbstractEDAGenerator >> commandJson [
	^ commandJson
]

{ #category : #accessing }
AbstractEDAGenerator >> commandJson: aString [
	commandJson := aString
]

{ #category : #accessing }
AbstractEDAGenerator >> commandName [
	^ commandName
]

{ #category : #accessing }
AbstractEDAGenerator >> commandName: aString [
	commandName := aString
]

{ #category : #accessing }
AbstractEDAGenerator >> commandRaw [
	^ commandRaw
]

{ #category : #accessing }
AbstractEDAGenerator >> commandRaw: aString [
	commandRaw := aString
]

{ #category : #helper }
AbstractEDAGenerator >> eventClassForContract: aString [
	^ ATSEDAApplication eventClassPrefix , (self dotSeparatedToCamelCase: aString)
]

{ #category : #accessing }
AbstractEDAGenerator >> eventFile [
	^ eventFile
]

{ #category : #accessing }
AbstractEDAGenerator >> eventFile: aString [
	eventFile := aString
]

{ #category : #accessing }
AbstractEDAGenerator >> eventJson [
	^ eventJson
]

{ #category : #accessing }
AbstractEDAGenerator >> eventJson: aString [
	eventJson := aString
]

{ #category : #accessing }
AbstractEDAGenerator >> eventName [
	^ eventName
]

{ #category : #accessing }
AbstractEDAGenerator >> eventName: aString [
	eventName := aString
]

{ #category : #accessing }
AbstractEDAGenerator >> eventRaw [
	^ eventRaw
]

{ #category : #accessing }
AbstractEDAGenerator >> eventRaw: aString [
	eventRaw := aString
]

{ #category : #helper }
AbstractEDAGenerator >> findRelativePathBetweenFile: aFileReference andFolder: aFolderReference [
	^ (self recursivelyFindRelativePathBetweenFile: aFileReference  andFolder: aFolderReference) reverse
]

{ #category : #helper }
AbstractEDAGenerator >> isCreate: json [
	| type meta |
	meta := json at: #meta ifAbsent: [ nil ].
	type := meta
		ifNil: [ '' ]
		ifNotNil: [ :m | m at: #type ifAbsent: [ nil ] ].
	^ '^CREATE_.+' asRegexIgnoringCase matches: type
]

{ #category : #helper }
AbstractEDAGenerator >> isCreateCommand [
	^ self isCreate: commandJson
]

{ #category : #helper }
AbstractEDAGenerator >> isCreatedEvent [
	^ self isCreate: commandJson
]

{ #category : #helper }
AbstractEDAGenerator >> isDelete: json [
	| delete meta |
	meta := json at: #meta ifAbsent: [ nil ].
	delete := meta
		ifNil: [ nil ]
		ifNotNil: [ :m | m at: #delete ifAbsent: [ nil ] ].
	^ delete isNotNil and: [ delete ]
]

{ #category : #helper }
AbstractEDAGenerator >> isDeleteCommand [
	^ self isDelete: commandJson
]

{ #category : #helper }
AbstractEDAGenerator >> isDeletedEvent [
	^ self isDelete: commandJson

]

{ #category : #helper }
AbstractEDAGenerator >> protocol [
	^ self generatedProtocolFor: self version
]

{ #category : #helper }
AbstractEDAGenerator >> readCommandExampleFile [
	| result stream |
	stream := self commandFile readStream.
	result := stream contents.
	stream close.
	^ result
]

{ #category : #helper }
AbstractEDAGenerator >> readCommandFromContract: contractName version: version [
	^ self readFromContract: [ self retrieveCommandFile: contractName version: version ]
]

{ #category : #helper }
AbstractEDAGenerator >> readEventExampleFile [
	| result stream |
	stream := self eventFile exists
		ifTrue: [ self eventFile readStream ]
		ifFalse: [ nil ].
	result := stream ifNil: [ nil ] ifNotNil: [ :s | s contents ].
	stream ifNotNil: [ :s | s close ].
	^ result
]

{ #category : #helper }
AbstractEDAGenerator >> readFromContract: evtName version: version using: aBlock [
	| result file fileContents |
	file := aBlock cull: evtName cull: version.
	fileContents := file readStream.
	result := NeoJSONReader fromString: fileContents.
	fileContents close.
	^ result
]

{ #category : #helper }
AbstractEDAGenerator >> recursivelyFindRelativePathBetweenFile: aFileReference andFolder: aFolderReference [
	((aFileReference isDirectory and: [ aFileReference = aFolderReference ])
		or: [ aFileReference parent = aFolderReference ])
		ifTrue: [ ^ OrderedCollection new ]
		ifFalse: [ | result |
			result := OrderedCollection with: aFileReference parent basename.
			result
				addAll: (self recursivelyFindRelativePathBetweenFile: aFileReference parent andFolder: aFolderReference).
			^ result ]
]

{ #category : #helper }
AbstractEDAGenerator >> retrieveAggregateAttributes [
	^ self retrieveEventAttributes
]

{ #category : #helper }
AbstractEDAGenerator >> retrieveAggregateAttributesBut: excluded [
	| result attrs |
	attrs := self retrieveAggregateAttributes.
	result := attrs select: [ :attr | (excluded includes: attr) not ].
	^ result
]

{ #category : #helper }
AbstractEDAGenerator >> retrieveAggregateClassName [
	^ self appName , (self underscoreSeparatedToCamelCase: self aggregate)
]

{ #category : #helper }
AbstractEDAGenerator >> retrieveAggregateClasses [
	"Retrieves all aggregate classes"
	^ EDAAggregateRoot allSubclasses
]

{ #category : #helper }
AbstractEDAGenerator >> retrieveAggregateIdNames [
	^ self retrieveAggregateClasses
	select: [ :cls | (cls name greaseString beginsWith: self appName) ]
		thenCollect: [ :cls |
			((self remove: self appName fromBeginningOf: cls name greaseString) , 'Id') uncapitalized ]
]

{ #category : #helper }
AbstractEDAGenerator >> retrieveAttributeValue: attr in: dict [
	| result body |
	body := dict at: #body.
	result := body at: attr ifAbsent: [ result := '' ].
	^ result
]

{ #category : #helper }
AbstractEDAGenerator >> retrieveAttributesFrom: dict [
	| vars body |
	body := dict at: #body.
	vars := body keys asSortedCollection.
	^ vars
]

{ #category : #helper }
AbstractEDAGenerator >> retrieveCommandAttributeValue: attr [
	^ self retrieveAttributeValue: attr in: self commandJson
]

{ #category : #helper }
AbstractEDAGenerator >> retrieveCommandAttributes [
	^ self retrieveAttributesFrom: self commandJson
]

{ #category : #helper }
AbstractEDAGenerator >> retrieveCommandAttributesBut: excluded [
	| result attrs |
	attrs := self retrieveCommandAttributes.
	result := attrs select: [ :attr | (excluded includes: attr) not ].
	^ result

]

{ #category : #helper }
AbstractEDAGenerator >> retrieveCommandClassName [
	^ self appName , (self toCamelCase: self commandName)
]

{ #category : #helper }
AbstractEDAGenerator >> retrieveEventAttributeValue: attr [
	^ self retrieveAttributeValue: attr in: self eventJson
]

{ #category : #helper }
AbstractEDAGenerator >> retrieveEventAttributes [
	^ self retrieveAttributesFrom: self eventJson
]

{ #category : #helper }
AbstractEDAGenerator >> retrieveEventAttributesBut: excluded [
	| result attrs |
	attrs := self retrieveEventAttributes.
	result := attrs select: [ :attr | (excluded includes: attr) not ].
	^ result
]

{ #category : #helper }
AbstractEDAGenerator >> retrieveEventClassName [
	^ self appName , (self toCamelCase: self eventName)
]

{ #category : #helper }
AbstractEDAGenerator >> retrieveEventName [
	| result aux |
	result := nil.
	aux := self eventName allRegexMatches: '([^_]*)'.
	aux size > 2
		ifTrue: [ | verb rest past |
			verb := aux at: 1.
			rest := aux allButFirst.
			past := self verbInPastTense: verb.
			result := ''.
			rest
				keysAndValuesDo: [ :i :noun | 
					i > 1
						ifTrue: [ result := result , '_' ].
					result := result , noun ].
			result := result , past ].
	^ result
]

{ #category : #helper }
AbstractEDAGenerator >> retrieveImplementedCommandsFor: appName [
	"Finds all pragmas like [appName]CommandName: #[COMMAND_NAME]"

	| cmds |
	cmds := {} asDictionary.
	EDACommand
		allSubclassesDo: [ :cls | (Pragma allNamed: (appName asLowercase , 'CommandName:') asSymbol in: cls class) do: [ :pragma | cmds at: (pragma arguments at: 1) put: pragma methodClass ] ].
	^ cmds
]

{ #category : #helper }
AbstractEDAGenerator >> retrieveMaxVersion [
	| parent |
	parent := self commandFile parent parent.
	parent entries isEmpty
		ifTrue: [ ^ -1 ]
		ifFalse: [ 
			^ ((parent entries
				select: [ :entry | entry isDirectory and: [ entry basename beginsWith: 'v' ] ]
				thenCollect: [ :entry | (EDAGenerator new removePrefix: 'v' from: entry basename) asInteger ])
				asOrderedCollection sort: [ :first :second | first < second ]) last ]
]

{ #category : #helper }
AbstractEDAGenerator >> retrieveRepositoryClassName [
	^ self appName , (self underscoreSeparatedToCamelCase: self aggregate) , 'Repository'
]

{ #category : #helper }
AbstractEDAGenerator >> retrieveVersion [
	^ (self removePrefix: 'v' from: self commandFile parent basename) asInteger
]

{ #category : #accessing }
AbstractEDAGenerator >> version [
	^ version
]

{ #category : #accessing }
AbstractEDAGenerator >> version: aNumber [
	version := aNumber
]
