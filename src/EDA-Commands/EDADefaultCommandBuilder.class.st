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
	meta := jsonDict at: #meta ifAbsent: [ nil ].
	body := jsonDict at: #body ifAbsent: [ nil ].
	(meta isNil or: [ body isNil ])
		ifTrue: [ self
				logErrorMessage: 'Invalid JSON (meta or body missing)'
				andThrow: EDAInvalidCommandMessage ]
		ifFalse: [ [ command := (self retrieveCommandClassFromJsonDict: jsonDict) new.
			command
				commandId: (meta at: #id);
				version: (meta at: #version);
				originalTimestamp: (DateAndTime fromString: (meta at: #timestamp)).
			(command isKindOf: EDAUserCommand)
				ifTrue: [ command authorUsername: (jsonDict at: #authorUsername) ].
				self copyFromDict: body intoCommand: command.
		.
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
						andThrow: EDAInvalidCommandMessage ] ]
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
EDADefaultCommandBuilder >> copyFromDict: aDictionary intoCommand: aCommand [
	aDictionary
		associationsDo: [ :assoc |
			| key |
			key := assoc key.
			key = 'version'
				ifFalse: [ key = 'id'
						ifTrue: [ key := 'aggregateRootId' ].
					[ aCommand
						instVarAt:
							(aCommand class
								instVarIndexFor: key
								ifAbsent: [ self logWarningMessage: 'No such inst var: ' , key ])
						put: assoc value ]
						on: Exception
						do: [ :ex |
							self
								logWarningMessage: key greaseString , ' does not exist in ' , aCommand class greaseString ] ] ].
	aCommand
		aggregateRootVersion: (aDictionary at: #aggregateRootVersion ifAbsent: [ 0 ])
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
