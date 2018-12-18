helper
eventClassForContract: aString
	^ ATSEDAApplication eventClassPrefix , (self dotSeparatedToCamelCase: aString)