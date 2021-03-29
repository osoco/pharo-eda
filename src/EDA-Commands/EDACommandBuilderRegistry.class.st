"
Class: EDACommandBuilderRegistry

This class holds the information about
which /builder/ is responsible of creating
which /command/.
By default, all commands get built by EDADefaultCommandBuilder,
unless the builder gets published in this registry.

Responsibility:

The only responsibility of this class
is to provide a way to retrieve the correct builder,
using the command name.

Public API:

- lookupBuilder: Retrieves the builder for a given command name.
- mapping: Allows registering custom builders.

Usage:

When a serialized command is received, 
the corresponding /materializer/
uses this class to find out which /builder/ to use
in order to create the command instance
representing the request.
"
Class {
	#name : #EDACommandBuilderRegistry,
	#superclass : #Object,
	#instVars : [
		'mapping'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'EDA-Commands-Builders'
}

{ #category : #API }
EDACommandBuilderRegistry class >> uniqueInstance [
	uniqueInstance ifNil: [ self uniqueInstance: self new ].
	^ uniqueInstance
]

{ #category : #API }
EDACommandBuilderRegistry class >> uniqueInstance: anInstance [
	uniqueInstance := anInstance.
]

{ #category : #API }
EDACommandBuilderRegistry >> addBuilder: builder forCommand: key [
    "Adds a builder mapping"
	self mapping at: key put: builder
]

{ #category : #initialization }
EDACommandBuilderRegistry >> doInitialize [
	self initializeMapping.
	self findAllPragmas.
]

{ #category : #private }
EDACommandBuilderRegistry >> findAllPragmas [
	(Pragma allNamed: #commandBuilderFor: inAndBelow: EDAApplication)
		do: [ :pragma | 
			pragma method origin new
				perform: pragma method selector
				withArguments: (Array with: self with: (pragma argumentAt: 1)) ]
]

{ #category : #initialization }
EDACommandBuilderRegistry >> initialize [
	| result |
	result := super initialize.
	self doInitialize.
	^ result
]

{ #category : #private }
EDACommandBuilderRegistry >> initializeMapping [
	"Initializes the mapping"

	mapping := Dictionary new
]

{ #category : #API }
EDACommandBuilderRegistry >> lookupBuilder: commandName [
	"Retrieves the builder for given command name"

	^ self mapping
		at: commandName
		ifAbsent: [ nil ]
]

{ #category : #private }
EDACommandBuilderRegistry >> mapping [
	"Retrieves the mapping, initializing it if necessary"

	mapping ifNil: [ self initializeMapping ].
	^ mapping
]
