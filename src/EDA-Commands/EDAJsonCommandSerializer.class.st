Class {
	#name : #EDAJsonCommandSerializer,
	#superclass : #EDACMessageSerializer,
	#traits : 'EDACPrintOnHelper',
	#classTraits : 'EDACPrintOnHelper classTrait',
	#instVars : [
		'writer'
	],
	#category : #'EDA-Commands-Serializers'
}

{ #category : #initialization }
EDAJsonCommandSerializer >> initialize [
	| paramsDictionary |
	writer := [ :aCommand | 
	| aux |
	aux := Dictionary new.
	paramsDictionary := Dictionary
		newFrom:
			(aCommand class instVarNames
				collect: [ :instVar | instVar -> (aCommand instVarNamed: instVar) ]).
	aux at: #params put: paramsDictionary.
	String
		streamContents: [ :stream | 
			(NeoJSONWriter on: stream)
				for: DateAndTime
					customDo:
						[ :mapping | mapping encoder: [ :dateAndTime | dateAndTime printString ] ];
				nextPut: aux ] ]
]

{ #category : #parsing }
EDAJsonCommandSerializer >> serialize: aCommand [
	^ self writer value: aCommand
]

{ #category : #accessing }
EDAJsonCommandSerializer >> writer [
	^ writer
]
