api
delegateProjectionTo: aProjector
	| start end |
	start := DateAndTime now.
	aProjector project.
	end := DateAndTime now.
	self class annotateDuration: end - start forProjector: aProjector class greaseString