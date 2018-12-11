persistence
selectMany: aProjectionClass where: aDictionary
	^ aProjectionClass selectMany: (self convertDictonaryToConditionalBlock: aDictionary)