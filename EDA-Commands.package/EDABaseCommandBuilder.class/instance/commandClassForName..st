protected
commandClassForName: aCommandName
    "Retrieves the command class for given name"
    ^ self commandClassPrefix ,
	    (aCommandName copyWithRegex: '_' matchesReplacedWith: ' ')
	        asLowercase asCamelCase