instance creation
forClass: aClass
	| result |
	result := EDAAggregateRootDoesNotExist new.
	result aggregateRootClass: aClass.
	^ result