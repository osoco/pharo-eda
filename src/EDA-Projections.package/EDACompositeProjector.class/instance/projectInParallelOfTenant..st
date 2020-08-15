api
projectInParallelOfTenant: aTenant
	| semaphore |
	semaphore := Semaphore new.
	self class headlessMode
		ifTrue: [ self projectors
				do: [ :projector |
					[ self delegateProjectionTo: projector ofTenant: aTenant.
					semaphore signal ] fork ] ]
		ifFalse: [ self projectors
				do: [ :projector |
					[ self delegateProjectionTo: projector ofTenant: aTenant.
					semaphore signal ] fork ]
				displayingProgress:
					[ :projector | 'Projection ' , projector class projectionClass greaseString ].
			self projectors size timesRepeat: [ semaphore wait ] ]
