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
	#classVars : [
		'Mapping'
	],
	#category : #'EDA-Commands-Builders'
}

{ #category : #API }
EDACommandBuilderRegistry class >> addBuilder: builder forCommand: key [
    "Adds a builder mapping"
	self mapping at: key put: builder
]

{ #category : #initialization }
EDACommandBuilderRegistry class >> initializeMapping [
	"Initializes the mapping"

	Mapping := Dictionary new
]

{ #category : #API }
EDACommandBuilderRegistry class >> lookupBuilder: commandName [
	"Retrieves the builder for given command name"

	^ self mapping
		at: commandName
		ifAbsent: [ nil ]
]

{ #category : #private }
EDACommandBuilderRegistry class >> mapping [
    "Retrieves the mapping, initializing it if necessary"
    Mapping ifNil: [ self initializeMapping ].
    ^ Mapping.

]
