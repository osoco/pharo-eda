api
delegateProjectionTo: aProjector ofTenant: aTenant
	| start end |
	start := DateAndTime now.
	aProjector projectOfTenant: aTenant.
	end := DateAndTime now.
	self class
		annotateDuration: end - start
		forProjector: aProjector class greaseString