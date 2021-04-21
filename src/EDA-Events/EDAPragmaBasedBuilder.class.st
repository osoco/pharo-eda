Class {
	#name : #EDAPragmaBasedBuilder,
	#superclass : #Object,
	#instVars : [
		'params',
		'name'
	],
	#category : #'EDA-Events-Builders'
}

{ #category : #builder }
EDAPragmaBasedBuilder class >> errorClass [
	self subclassResponsibility 
]

{ #category : #'instance creation' }
EDAPragmaBasedBuilder class >> newFor: aName with: params [
	^ self new
		name: aName;
		params: params;
		yourself
]

{ #category : #builder }
EDAPragmaBasedBuilder >> build [
	^ self buildOrElseError: self errorClass
]

{ #category : #builder }
EDAPragmaBasedBuilder >> buildOrElseError: anErrorClass [
	| result class pragma |
	pragma := self retrievePragma.
	pragma
		ifNil: [ anErrorClass new
				signal: self name greaseString , ' is not supported' ].
	class := self class environment
		at: pragma methodClass allInstances first greaseString asSymbol.
	(pragma method hasPragmaNamed: #builderClass:)
		ifTrue: [ | builder |
			builder := (self class environment
				at:
					((pragma method pragmas select: [ :p | p selector = #builderClass: ])
						first argumentAt: 1)) with: self params.
			result := class perform: pragma method selector with: builder ]
		ifFalse: [ EDAInternalError
				signal:
					'Method ' , pragma method
						,
							' does not contain a #builderClass: pragma specifying its builder class' ].
	^ result
]

{ #category : #builder }
EDAPragmaBasedBuilder >> errorClass [
	^ self class errorClass
]

{ #category : #accessing }
EDAPragmaBasedBuilder >> name [
	^ name
]

{ #category : #accessing }
EDAPragmaBasedBuilder >> name: anObject [
	name := anObject
]

{ #category : #accessing }
EDAPragmaBasedBuilder >> params [
	^ params
]

{ #category : #accessing }
EDAPragmaBasedBuilder >> params: anObject [
	params := anObject
]

{ #category : #pragmas }
EDAPragmaBasedBuilder >> retrievePragma [
	self subclassResponsibility
]

{ #category : #pragmas }
EDAPragmaBasedBuilder >> retrievePragma: aSymbol inAndBelow: aClass [
	| candidates |
	candidates := (Pragma allNamed: aSymbol inAndBelow: aClass)
		select: [ :p | (p argumentAt: 1) = self name ].
	candidates
		ifEmpty: [ self errorClass new
				signal: 'No pragma found for ' , aSymbol greaseString ].
	candidates size > 1
		ifTrue: [ | message |
			message := String new
				streamContents: [ :str | 
					str
						nextPutAll: 'More than one pragma found for ';
						nextPutAll: aSymbol greaseString;
						nextPutAll: '. Found: '.
					candidates
						do: [ :c | str nextPutAll: c selector greaseString ]
						separatedBy: [ str nextPutAll: ', ' ] ].
			self errorClass signal: message ].
	^ candidates first
]
