api
projectOfTenant: aTenant
	| start end |
	(self class synchronizationInProgressOfTenant: aTenant)
		ifTrue: [ ^ self ].
	self class synchronizationInProgressOfTenant: aTenant is: true.
	start := DateAndTime now.
	self class concurrentSynchronization
		ifTrue: [ self projectInParallelOfTenant: aTenant ]
		ifFalse: [ self projectSequentiallyOfTenant: aTenant ].
	end := DateAndTime now.
	self class
		annotateDuration: end - start
		forProjector: self class greaseString.
	self class synchronizationInProgress: false