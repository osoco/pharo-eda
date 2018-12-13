api
projectInParallel
	| semaphore |
	semaphore := Semaphore new.
	Smalltalk isHeadless
		ifTrue: [ self projectors
				do: [ :projector | 
					[ self delegateProjectionTo: projector.
					semaphore signal ] fork ] ]
		ifFalse: [ self projectors
				do: [ :projector | 
					[ self delegateProjectionTo: projector.
					semaphore signal ] fork ]
				displayingProgress: [ :projector | 'Projection ' , projector class projectionClass greaseString ].
			self projectors size timesRepeat: [ semaphore wait ] ]