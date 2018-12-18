writing
writeError: error 
	| aux paramsDict |
	aux := Dictionary new.
	aux at: #name put: (EDAMessageSerializer nameWithoutPrefixForMessageClass: error).
	paramsDict := Dictionary
		newFrom:
			{('error' -> true).
			('description' -> error description)}.
	aux at: #params put: paramsDict.
	^ String streamContents: [ :stream | (NeoJSONWriter on: stream) nextPut: aux ]