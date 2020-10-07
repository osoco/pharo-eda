persistence
selectOfTenant: aTenant one: aProjectionClass where: aDictionary
	| criteria |
	criteria := Dictionary newFrom: aDictionary.
	criteria at: 'tenant' put: aTenant.
	^ aProjectionClass selectOne: criteria