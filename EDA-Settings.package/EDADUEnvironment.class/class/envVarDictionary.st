private
envVarDictionary
	| result |
	result := Dictionary new.
	self envVarDictionaryFiles do: [ :envFile |
		envFile exists 
			ifTrue: [ result := result union: (NeoJSONReader on: envFile readStream) parseMap ]].
	
	result ifEmpty: [ NotFound signal: (self envVarDictionaryFiles asCommaString) ]
			 ifNotEmptyDo: [ :n | ^n ]