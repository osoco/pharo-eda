api
projectSequentiallyOfTenant: aTenant
	(self projectorsByTenant: aTenant)
		ifEmpty: [ self logErrorMessage: 'No projector for tenant ' , aTenant ]
		ifNotEmpty: [ :projectors | 
			self class headlessMode
				ifTrue: [ projectors
						do:
							[ :projector | self delegateProjectionTo: projector ofTenant: aTenant ] ]
				ifFalse: [ projectors
						do:
							[ :projector | self delegateProjectionTo: projector ofTenant: aTenant ]
						displayingProgress:
							[ :projector | 'Projection ' , projector class projectionClass greaseString ] ] ]