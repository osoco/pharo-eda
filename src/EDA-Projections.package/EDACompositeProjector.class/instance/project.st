api
project
	| start end |
	self class synchronizationInProgress
		ifTrue: [ ^ self ].
	self class synchronizationInProgress: true.
	start := DateAndTime now.
	self class concurrentSynchronization
		ifTrue: [ self projectInParallel ]
		ifFalse: [ self projectSequentially ].
	end := DateAndTime now.
	self class annotateDuration: end - start forProjector: self class greaseString.
		self class synchronizationInProgress: false