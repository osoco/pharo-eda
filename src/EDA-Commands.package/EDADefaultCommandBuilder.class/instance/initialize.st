initialization
initialize
	commandDictionary := Dictionary new.
	self initializeCommandMappings.
	self initializeSpecificCommandMappings