compilation-support
containsAnyDisableRegenerationMethod: aClass
	^ (self retrieveDisableRegenerationPragmas: aClass) isNotEmpty