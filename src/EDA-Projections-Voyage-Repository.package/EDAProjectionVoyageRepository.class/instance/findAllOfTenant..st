persistence
findAllOfTenant: aTenant
	| criteria |
	criteria := Dictionary new.
	criteria at: 'tenant' put: aTenant.
	^ self selectMany: self where: criteria