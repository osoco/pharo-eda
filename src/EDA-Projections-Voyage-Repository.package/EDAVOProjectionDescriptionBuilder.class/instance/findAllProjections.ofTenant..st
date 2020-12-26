persistence
findAllProjections: aClass ofTenant: aTenant
	| criteria |
	criteria := Dictionary new.
	criteria at: 'tenant' put: aTenant.
	^ self
		selectMany: aClass
		where: criteria
		sortBy:
			(OrderedCollection
				with: #timestamp -> VOOrder ascending
				with: #_id -> VOOrder ascending) asDictionary