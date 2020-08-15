api
projectSequentiallyOfTenant: aTenant
	self class headlessMode
		ifTrue: [ self projectors
				do: [ :projector | self delegateProjectionTo: projector ofTenant: aTenant] ]
		ifFalse: [ self projectors
				do: [ :projector | self delegateProjectionTo: projector ofTenant: aTenant]
				displayingProgress:
					[ :projector | 'Projection ' , projector class projectionClass greaseString ] ]