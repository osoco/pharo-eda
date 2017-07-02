initialization
initializeWriter
	writer := [ :object | 
	| aux |
	aux := Dictionary
		newFrom: (object class allInstVarNames collect: [ :instVar | instVar -> (object instVarNamed: instVar) ]).
	String streamContents: [ :stream | 
		(NeoJSONWriter on: stream) 
		for: DateAndTime customDo: [ :mapping |
    		mapping encoder: [ :dateAndTime | dateAndTime = '<ANYTHING>' ifTrue: [ dateAndTime ] ifFalse: [ dateAndTime printString ] ] ];
		nextPut: aux.
		] 
	].
