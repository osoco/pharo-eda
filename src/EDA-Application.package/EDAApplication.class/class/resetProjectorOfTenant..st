reset - projections
resetProjectorOfTenant: aTenant
	| projector |
	projector := self projectorsByTenant at: aTenant ifAbsent: [ nil ].
	projector
		ifNotNil: [ :p | p class synchronizationInProgressOfTenant: aTenant is: false .
	self projectorsByTenant removeKey: aTenant ]