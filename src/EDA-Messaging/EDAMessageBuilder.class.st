Class {
	#name : #EDAMessageBuilder,
	#superclass : #EDABuilder,
	#traits : 'EDATPragmaHelper',
	#classTraits : 'EDATPragmaHelper classTrait',
	#category : #'EDA-Messaging-Builders'
}

{ #category : #builder }
EDAMessageBuilder >> build [
	| pragma |
	pragma := self retrieveBuildPragma.
	^ pragma methodClass perform: pragma selector with: self
]

{ #category : #meta }
EDAMessageBuilder >> errorClass [
	self subclassResponsibility
]

{ #category : #meta }
EDAMessageBuilder >> messageClass [
	self subclassResponsibility 
]

{ #category : #testing }
EDAMessageBuilder >> messageSupported [
	^ self retrieveBuildPragma isNotNil
]

{ #category : #meta }
EDAMessageBuilder >> pragmaSymbol [
	self subclassResponsibility
]

{ #category : #testing }
EDAMessageBuilder >> retrieveBuildPragma [
	^ self retrieveBuildPragmaFor: self pragmaSymbol inAndBelow: self messageClass
]

{ #category : #testing }
EDAMessageBuilder >> retrieveBuildPragmaFor: aSymbol inAndBelow: aMessageClass [
	| type pragmas |
	type := self retrieveType: self params.
	pragmas := self
		retrievePragmas: aSymbol
		with: type
		inAndBelow: aMessageClass class.
	pragmas isNil or: [ 
	pragmas size > 1
		ifTrue: [ | message |
			message := String new
				streamContents: [ :str | 
					str
						nextPutAll: 'More than one pragma ';
						nextPutAll: aSymbol greaseString;
						nextPutAll: ' found: '.
					pragmas
						do: [ :c | str nextPutAll: c selector greaseString ]
						separatedBy: [ str nextPutAll: ', ' ] ].
			self errorClass signal: message ] ].
	^ pragmas first
]

{ #category : #testing }
EDAMessageBuilder >> retrieveType: aDictionary [
	self subclassResponsibility
]
