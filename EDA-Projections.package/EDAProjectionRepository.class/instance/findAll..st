persistence
findAll: aProjectionClass
	^ self selectMany: aProjectionClass where: Dictionary new