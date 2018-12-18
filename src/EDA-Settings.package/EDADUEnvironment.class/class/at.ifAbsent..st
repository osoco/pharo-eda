accessing
at: aSymbol ifAbsent: aBlock
	"read in the json file the current value for the environment"
	^self envVarDictionary at: aSymbol ifAbsent: aBlock