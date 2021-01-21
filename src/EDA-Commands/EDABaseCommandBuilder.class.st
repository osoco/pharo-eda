"
Class: EDABaseCommandBuilder

Base class for all command builders.

Responsibility:

It's responsible of providing common logic
useful when specialized builders
need to create commands.

Public API:

This class does not export any public API.
It does export some methods to be used by
its children, though.
- commandClassForName: to guess the class based on the command name.
- commandClassPrefix: the generic EDA class prefix.
- buildWith:/takes care of the commonalities of all commands.

Usage:

This class is not used directly.
"
Class {
	#name : #EDABaseCommandBuilder,
	#superclass : #Object,
	#category : 'EDA-Commands-Builders'
}

{ #category : #protected }
EDABaseCommandBuilder >> buildWith: commandParams [
	"Builds a command from given parameters"

	| command version |
	command := (self retrieveCommandClassFromParams: commandParams) new.
	command commandId: (commandParams at: #commandId).
	version := (commandParams at: #aggregateRootVersion ifAbsent: [ nil ]).
	version := version ifNil: [ commandParams at: #version ifAbsent: [ 0 ] ].
	command aggregateRootVersion: version.
	command version: version.
	command aggregateRootClass: (self retrieveAggregateRootClass: commandParams).
	(command isKindOf: EDAUserCommand)
		ifTrue:
			[ command authorUsername: (commandParams at: #authorUsername) ].
	^ command
]

{ #category : #protected }
EDABaseCommandBuilder >> commandClassForName: aCommandName [
    "Retrieves the command class for given name"
    ^ self commandClassPrefix ,
	    (aCommandName copyWithRegex: '_' matchesReplacedWith: ' ')
	        asLowercase asCamelCase
]

{ #category : #public }
EDABaseCommandBuilder >> commandClassPrefix [
   "Returns the class prefix for application's commands"
	self subclassResponsibility 
]

{ #category : #protected }
EDABaseCommandBuilder >> retrieveAggregateRootClass: jsonDict [
	self subclassResponsibility
]

{ #category : #protected }
EDABaseCommandBuilder >> retrieveCommandClassFromParams: commandParams [
	^ (self class environment	at: (self commandClassForName: (commandParams at: #name)))
]
