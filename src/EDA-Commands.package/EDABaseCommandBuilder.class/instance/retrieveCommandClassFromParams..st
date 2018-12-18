protected
retrieveCommandClassFromParams: commandParams
	^ (self class environment	at: (self commandClassForName: (commandParams at: #name)))