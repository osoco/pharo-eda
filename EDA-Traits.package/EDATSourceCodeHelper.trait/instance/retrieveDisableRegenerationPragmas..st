compilation-support
retrieveDisableRegenerationPragmas: aClass
	^ self retrieveMethodsInClass: aClass withPragma: 'disable_regeneration'
