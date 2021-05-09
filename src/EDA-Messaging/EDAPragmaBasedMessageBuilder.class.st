Class {
	#name : #EDAPragmaBasedMessageBuilder,
	#superclass : #EDABuilder,
	#traits : 'EDATPragmaHelper',
	#classTraits : 'EDATPragmaHelper classTrait',
	#category : #'EDA-Messaging-Builders'
}

{ #category : #builder }
EDAPragmaBasedMessageBuilder >> build [
	| pragma |
	pragma := self retrieveBuildPragma.
	^ pragma method methodClass allInstances first perform: pragma method selector with: self
]

{ #category : #meta }
EDAPragmaBasedMessageBuilder >> errorClass [
	self subclassResponsibility
]

{ #category : #meta }
EDAPragmaBasedMessageBuilder >> messageClass [
	self subclassResponsibility 
]

{ #category : #testing }
EDAPragmaBasedMessageBuilder >> messageSupported [
	^ self retrieveBuildPragma isNotNil
]

{ #category : #meta }
EDAPragmaBasedMessageBuilder >> pragmaSymbol [
	self subclassResponsibility
]

{ #category : #testing }
EDAPragmaBasedMessageBuilder >> retrieveBuildPragma [
	^ self retrieveBuildPragmaFor: self pragmaSymbol inAndBelow: self messageClass
]

{ #category : #testing }
EDAPragmaBasedMessageBuilder >> retrieveBuildPragmaFor: aSymbol inAndBelow: aMessageClass [
	| type pragmas |
	type := self retrieveType.
	pragmas := self
		retrievePragmas: aSymbol
		with: type
		inAndBelow: aMessageClass class.
	pragmas isNil
		or: [ pragmas size > 1
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
EDAPragmaBasedMessageBuilder >> retrieveType [
	^ self retrieveType: self params
]

{ #category : #testing }
EDAPragmaBasedMessageBuilder >> retrieveType: aDictionary [
	self subclassResponsibility
]
