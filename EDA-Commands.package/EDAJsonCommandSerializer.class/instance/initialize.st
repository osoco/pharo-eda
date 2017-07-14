initialization
initialize
	| paramsDictionary |
	writer := [ :aCommand | 
	| aux |
	aux := Dictionary new.
	aux at: #name put: (EDAMessageSerializer nameForMessageClass: aCommand class).
	aux at: #commandId put: aCommand commandId.
	aux at: #aggregateRootVersion put: aCommand aggregateRootVersion.
	aux at: #authorUsername put: aCommand authorUsername.
	paramsDictionary := Dictionary
		newFrom: (aCommand class instanceVariables collect: [ :instVar | instVar -> (aCommand instVarNamed: instVar) ]).
	aux at: #params put: paramsDictionary.
	String
		streamContents: [ :stream | 
			(NeoJSONWriter on: stream)
				for: DateAndTime customDo: [ :mapping | mapping encoder: [ :dateAndTime | dateAndTime printString ] ];
				nextPut: aux ] ]