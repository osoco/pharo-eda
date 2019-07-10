accessing
at: aSymbol ifAbsent: aBlock
	"read in the json file the current value for the environment"

	| value |
	value := self envVarDictionary at: aSymbol ifAbsent: aBlock.
	self logDebugMessage: 'config/' , self currentEnvironment greaseString , '.json: ''' , aSymbol greaseString , ''' -> ''' , value greaseString , ''''.
	^ value