api
projectSequentially
	Smalltalk isHeadless
		ifTrue: [ self projectors do: [ :projector | self delegateProjectionTo: projector ] ]
		ifFalse: [ self projectors do: [ :projector | self delegateProjectionTo: projector ] displayingProgress: [ :projector | 'Projection ' , projector class projectionClass greaseString ] ]