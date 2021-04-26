Class {
	#name : #EDAMaterializer,
	#superclass : #Object,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#instVars : [
		'builderClasses',
		'parserClasses'
	],
	#category : #'EDA-Messaging-Materializers'
}

{ #category : #initialization }
EDAMaterializer class >> parentBuilderClass [
	self subclassResponsibility
]

{ #category : #initialization }
EDAMaterializer class >> parentParserClass [
	^ EDAMessageParser
]

{ #category : #private }
EDAMaterializer >> build: aDictionary [
	"Returns a command or event instance from given dictionary"

	| builderCollection noBuilderFound |
	builderCollection := (self buildersFor: aDictionary)
		select: [ :r | r messageSupported ].
	noBuilderFound := builderCollection isNil
		or: [ builderCollection isEmpty ].
	noBuilderFound
		ifTrue: [ self
				logErrorMessage:
					(String
						streamContents: [ :s | 
							s
								nextPutAll: 'No builders know how to handle the input message ';
								nextPut: Character cr;
								nextPutAll: aDictionary greaseString])
				andThrow: EDAInvalidMessage ].
	^ builderCollection first build
]

{ #category : #accessing }
EDAMaterializer >> builderClasses [
	^ builderClasses
		ifNil: [ self builderClasses: self findBuilderClasses.
			builderClasses ]
]

{ #category : #accessing }
EDAMaterializer >> builderClasses: anObject [
	builderClasses := anObject
]

{ #category : #accessing }
EDAMaterializer >> builderFor: aString with: aMap [
	self subclassResponsibility
]

{ #category : #initialization }
EDAMaterializer >> buildersFor: aDictionary [
	^ (self builderClasses collect: [ :c | c with: aDictionary ])
		select: [ :i | i messageSupported ]
]

{ #category : #initialization }
EDAMaterializer >> findBuilderClasses [
	^ (self parentBuilderClass subclasses)
		sorted: [ :a :b | a priority > b priority ]
]

{ #category : #initialization }
EDAMaterializer >> findParserClasses [
	^ self parentParserClass subclasses
		sorted: [ :a :b | a priority > b priority ]
]

{ #category : #private }
EDAMaterializer >> materialize: aString [
	"Returns a command or event instance from given message"

	^ self build: (self parse: aString)
]

{ #category : #initialization }
EDAMaterializer >> parentBuilderClass [
	^ self class parentBuilderClass
]

{ #category : #initialization }
EDAMaterializer >> parentParserClass [
	^ self class parentParserClass
]

{ #category : #private }
EDAMaterializer >> parse: aString [
	"Returns a Dictionary from given message"

	| parserCollection noParserFound |
	parserCollection := (self parsersFor: aString)
		select: [ :p | p messageSupported ].
	noParserFound := parserCollection isNil
		or: [ parserCollection isEmpty ].
	noParserFound
		ifTrue: [ self
				logErrorMessage:
					'No parsers know how to handle the input message ' , Character cr
						, aString greaseString
				andThrow: EDAInvalidCommandMessage ].
	^ parserCollection first parse
]

{ #category : #accessing }
EDAMaterializer >> parserClasses [
	^ parserClasses
		ifNil: [ self parserClasses: self findParserClasses.
			parserClasses ]
]

{ #category : #accessing }
EDAMaterializer >> parserClasses: anObject [
	parserClasses := anObject
]

{ #category : #initialization }
EDAMaterializer >> parsersFor: aString [
	^ (self parserClasses collect: [ :c | c with: aString ])
		select: [ :i | i messageSupported ]
]
