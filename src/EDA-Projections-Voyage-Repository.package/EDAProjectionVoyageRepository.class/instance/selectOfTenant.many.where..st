persistence
selectOfTenant: aTenant many: aProjectionClass where: aDictionary
	| criteria |
	criteria := Dictionary newFrom: aDictionary.
	criteria at: 'tenant' put: aTenant.
	^ aProjectionClass selectMany: criteria.