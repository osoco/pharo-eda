api
project
	| start end |
	start := DateAndTime now.
	self class concurrentSynchronization
		ifTrue: [ self projectInParallel ]
		ifFalse: [ self projectSequentially ].
	end := DateAndTime now.
	self class annotateDuration: (end - start) forProjector: self class greaseString