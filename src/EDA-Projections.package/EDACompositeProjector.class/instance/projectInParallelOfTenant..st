api
projectInParallelOfTenant: aTenant
	| semaphore |
	semaphore := Semaphore new.
	(self projectorsByTenant: aTenant)
		ifEmpty: [ self logErrorMessage: 'No projector for tenant ' , aTenant ]
		ifNotEmpty: [ :specificProjectors | 
			self class headlessMode
				ifTrue: [ specificProjectors
						do:
							[ :projector | 
							self delegateProjectionTo: projector ofTenant: aTenant.
							semaphore signal ] fork ]
				ifFalse: [ specificProjectors
						do: [ :projector | 
							[ self delegateProjectionTo: projector ofTenant: aTenant.
							semaphore signal ] fork ]
						displayingProgress:
							[ :projector | 'Projection ' , projector class projectionClass greaseString ].
					specificProjectors size timesRepeat: [ semaphore wait ] ] ]