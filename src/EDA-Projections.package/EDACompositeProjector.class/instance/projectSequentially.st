api
projectSequentially
	self class headlessMode
		ifTrue: [ self projectors do: [ :projector | self delegateProjectionTo: projector ] ]
		ifFalse: [ self projectors
				do: [ :projector | self delegateProjectionTo: projector ]
				displayingProgress: [ :projector | 'Projection ' , projector class projectionClass greaseString ] ]