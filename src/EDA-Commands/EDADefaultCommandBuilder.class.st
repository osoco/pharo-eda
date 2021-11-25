Class {
	#name : #EDADefaultCommandBuilder,
	#superclass : #EDABaseCommandBuilder,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#instVars : [
		'commandDictionary'
	],
	#category : #'EDA-Commands-Builders'
}

{ #category : #building }
EDADefaultCommandBuilder >> buildCommandFromCommandName: commandName [
	| result |
	result := commandDictionary at: commandName ifAbsent: [ nil ].
	result
		ifNil: [ self
				logErrorMessage: (String streamContents: [ :s | s nextPutAll:
					self class greaseString; nextPutAll: ' does not currently know how to build '
						; nextPutAll: commandName greaseString ; nextPutAll: ' commands. Check '
						; nextPutAll: self class greaseString ; nextPutAll: '>>initializeCommandMappings' ])
				andThrow: EDACommandError ].
	^ result new
]

{ #category : #building }
EDADefaultCommandBuilder >> buildEmptyFromJsonDict: jsonDict [
	| meta body |
	meta := jsonDict at: #meta.
	body := jsonDict at: #body.
	^ self buildCommandFromCommandName: (meta at: #type)
]

{ #category : #building }
EDADefaultCommandBuilder >> buildWith: jsonDict [
	| command meta body |
	meta := jsonDict at: #meta ifAbsent: [ self logErrorMessage: 'Invalid JSON meta missing)' andThrow: EDAInvalidCommandMessage ].
	body := jsonDict at: #body ifAbsent: [ self logErrorMessage: 'Invalid JSON body missing)' andThrow: EDAInvalidCommandMessage ].
	[
		command := (self retrieveCommandClassFromJsonDict: jsonDict) new.
		self copyFromMetaDict: meta intoCommand: command.
		self copyFromBodyDict: body intoCommand: command.
		(command isKindOf: EDAUserCommand)
			ifTrue: [ command authorUsername: (jsonDict at: #authorUsername) ].
		^ command ]
	on: Exception
	do: [ :ex |
		self
			logErrorMessage:
				((WriteStream on: String new)
					nextPutAll: 'Command rejected: ';
					nextPutAll: ex greaseString;
					close;
					contents)
			andThrow: EDAInvalidCommandMessage ]
]

{ #category : #accessing }
EDADefaultCommandBuilder >> commandDictionary [
	^ commandDictionary
]

{ #category : #accessing }
EDADefaultCommandBuilder >> commandDictionary: anObject [
	commandDictionary := anObject
]

{ #category : #building }
EDADefaultCommandBuilder >> copyFromBodyDict: aBodyDict intoCommand: aCommand [
	aBodyDict changeKey: #id to: #aggregateRootId.
	aBodyDict changeKey: #version to: #aggregateRootVersion.
	self copyFromDict: aBodyDict intoCommand: aCommand.
]

{ #category : #building }
EDADefaultCommandBuilder >> copyFromDict: aDictionary intoCommand: aCommand [
	aDictionary
		associationsDo: [ :assoc |
			| key value |
			value := assoc value.
			"do not set the new value if it is nil to avoid removing the initialized values"
			value ifNotNil: [
				key := assoc key.
				[	aCommand
						instVarNamed: key
						put: assoc value
						ifAbsent: [ self logWarningMessage: 'No such inst var: ' , key ] ]
				on: Exception
				do: [ :ex |
					self
						logWarningMessage: key greaseString , ' does not exist in ' , aCommand class greaseString ] ] ]
]

{ #category : #building }
EDADefaultCommandBuilder >> copyFromMetaDict: aMetaDict intoCommand: aCommand [
	aMetaDict changeKey: #id to: #commandId.
	aMetaDict changeKey: #timestamp to: #originalTimestamp.
	aMetaDict
		at: #originalTimestamp 
		ifPresent: [ :time |
			aMetaDict at: #originalTimestamp put: (DateAndTime fromString: time) ].
	self copyFromDict: aMetaDict intoCommand: aCommand.
]

{ #category : #initialization }
EDADefaultCommandBuilder >> initialize [
	commandDictionary := Dictionary new.
	self initializeCommandMappings.
	self initializeSpecificCommandMappings
]

{ #category : #initialization }
EDADefaultCommandBuilder >> initializeCommandBuilders [
	self subclassResponsibility

]

{ #category : #initialization }
EDADefaultCommandBuilder >> initializeCommandMappings [
	self subclassResponsibility
]

{ #category : #initialization }
EDADefaultCommandBuilder >> initializeSpecificCommandMappings [
	self subclassResponsibility
]

{ #category : #initialization }
EDADefaultCommandBuilder >> retrieveAggregateRootClass: commandParams [
	^ (self retrieveCommandClassFromJsonDict: commandParams) new aggregateRootClass
]

{ #category : #building }
EDADefaultCommandBuilder >> retrieveCommandClassFromCommandName: commandName [
	| result |
	result := commandDictionary at: commandName ifAbsent: [ nil ].
	result
		ifNil: [ self
				logErrorMessage: (String streamContents: [ :s | s nextPutAll:
					self class greaseString ; nextPutAll: ' does not currently know how to build '
						; nextPutAll: commandName greaseString ; nextPutAll: ' commands. Check '
						; nextPutAll: self class greaseString ; nextPutAll: '>>initializeCommandMappings' ])
				andThrow: EDACommandError ].
	^ result
]

{ #category : #building }
EDADefaultCommandBuilder >> retrieveCommandClassFromJsonDict: jsonDict [
	| meta body |
	meta := jsonDict at: #meta.
	body := jsonDict at: #body.
	^ self retrieveCommandClassFromCommandName: (meta at: #type)
]
