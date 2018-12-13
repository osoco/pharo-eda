parsing
nameWithoutPrefixForMessageClass: aMessageClass
	^ aMessageClass asString allButFirst: (self eventClassPrefix: aMessageClass) size