initialization
initialize
	writer := [ :object |
	| aux |
	aux := Dictionary
		newFrom: (object class allInstVarNames collect: [ :instVar | instVar -> (object instVarNamed: instVar) ]).
	String streamContents: [ :stream |
		(NeoJSONWriter on: stream)
		for: DateAndTime customDo: [ :mapping |
		mapping encoder: [ :dateAndTime | dateAndTime printString ] ];
		nextPut: aux.
		]
	].

	errorWriter := [ :error |
	| aux paramsDict |
	aux := Dictionary new.
	aux at: #name put: (EDAMessageSerializer nameWithoutPrefixForMessageClass: error).
	paramsDict := Dictionary
		newFrom:
			{('error' -> true).
			('description' -> error description)}.
	aux at: #params put: paramsDict.
	String streamContents: [ :stream | (NeoJSONWriter on: stream) nextPut: aux ] ]