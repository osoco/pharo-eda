persistence
selectOne: aProjectionClass where: aDictionary
	^ aProjectionClass selectOne: (self convertDictonaryToConditionalBlock: aDictionary)