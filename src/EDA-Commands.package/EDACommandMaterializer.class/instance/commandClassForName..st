parsing
commandClassForName: aCommandName
	^ self commandClassPrefix , (aCommandName copyWithRegex: '_' matchesReplacedWith: ' ') asLowercase asCamelCase