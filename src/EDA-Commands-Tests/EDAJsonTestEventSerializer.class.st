Class {
	#name : #EDAJsonTestEventSerializer,
	#superclass : #EDAJsonEventSerializer,
	#category : 'EDA-Commands-Tests'
}

{ #category : #initialization }
EDAJsonTestEventSerializer >> serialize: anEvent [
	| aux |
	aux := Dictionary
		newFrom:
			(anEvent class allInstVarNames
				collect: [ :instVar | instVar -> (anEvent instVarNamed: instVar) ]).
	String
		streamContents: [ :stream |
			(NeoJSONWriter on: stream)
				for: DateAndTime
					customDo: [ :mapping |
					mapping
						encoder: [ :dateAndTime |
							dateAndTime = '<ANYTHING>'
								ifTrue: [ dateAndTime ]
								ifFalse: [ dateAndTime printString ] ] ];
				nextPut: aux ]
]

{ #category : #initialization }
EDAJsonTestEventSerializer >> serialize: anEvent forAggregateClass: aggregateClass ofType: eventType version: aVersion [
	| result |
	result := WriteStream with: String new.
	result nextPutAll:'{ "meta": { "id": "<ANYTHING>", "aggregate": "';
	nextPutAll: aggregateClass;
	nextPutAll: '", "type": "';
	nextPutAll: eventType;
	nextPutAll: '", "version": "';
	nextPutAll: '", "correlationId": "<ANYTHING>" }, "body": ';
	nextPutAll: (super serialize: anEvent);
	nextPut: $}.
	^ result contents
]
