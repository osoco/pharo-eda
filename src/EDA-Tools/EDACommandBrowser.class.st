Class {
	#name : #EDACommandBrowser,
	#superclass : #ComposableModel,
	#instVars : [
		'list'
	],
	#category : 'EDA-Tools'
}

{ #category : #'as yet unclassified' }
EDACommandBrowser class >> defaultSpec [
	^ SpecLayout composed
		add: #list;
		yourself
]

{ #category : #'as yet unclassified' }
EDACommandBrowser >> initializeWidgets [
	list := self newList.
	list items: ((EDACommand allSubclasses select: [ :commandClass | (commandClass name beginsWith: 'EDA') not ]) sorted: [ :a :b | a name < b name ]).
	self focusOrder add: list
]

{ #category : #'as yet unclassified' }
EDACommandBrowser >> list [
	^ list
]

{ #category : #'as yet unclassified' }
EDACommandBrowser >> title [
	^ 'EDA Commands'
]

{ #category : #'as yet unclassified' }
EDACommandBrowser >> whenSelectedItemChanged: aBlock [
	list whenSelectedItemChanged: aBlock
]
