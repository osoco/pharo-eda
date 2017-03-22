compilation
containsAnyDisableRegenerationMethod: aClass
	^ (self retrieveDisableRegenerationPragmas: aClass) size > 0