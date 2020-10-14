initialization
serialize: anEvent
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