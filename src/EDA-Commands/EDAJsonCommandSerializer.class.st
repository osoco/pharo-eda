Class {
	#name : #EDAJsonCommandSerializer,
	#superclass : #EDAMessageSerializer,
	#traits : 'EDATPrintOnHelper',
	#classTraits : 'EDATPrintOnHelper classTrait',
	#instVars : [
		'writer'
	],
	#category : #'EDA-Commands-Serializers'
}

{ #category : #initialization }
EDAJsonCommandSerializer >> initialize [
	| paramsDictionary |
	writer := [ :aCommand | 
	paramsDictionary := Dictionary
		newFrom:
			(aCommand class instVarNames
				collect: [ :instVar | instVar -> (aCommand instVarNamed: instVar) ]).
	paramsDictionary at: #type ifAbsentPut: [ aCommand class greaseString ].
	String
		streamContents: [ :stream | 
			(NeoJSONWriter on: stream)
				for: DateAndTime
					customDo:
						[ :mapping | mapping encoder: [ :dateAndTime | dateAndTime printString ] ];
				for: BlockClosure
					customDo: [ :mapping | mapping encoder: [ :closure | closure printString ] ];
				for: Object
					customDo: [ :mapping | mapping encoder: [ :obj | obj printString ] ];
				for: Object class
					customDo: [ :mapping | mapping encoder: [ :cls | cls printString ] ];
				nextPut: paramsDictionary ] ]
]

{ #category : #parsing }
EDAJsonCommandSerializer >> serialize: aCommand [
	^ self writer value: aCommand
]

{ #category : #accessing }
EDAJsonCommandSerializer >> writer [
	^ writer
]
