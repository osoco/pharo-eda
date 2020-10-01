accessing
projectorsByTenant: aTenant
	| result |
	result := self projectorsByTenant at: aTenant ifAbsent: [ OrderedCollection new ].
	self projectorsByTenant at: aTenant put: result.
	^ result