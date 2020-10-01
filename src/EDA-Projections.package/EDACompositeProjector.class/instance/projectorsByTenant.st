accessing
projectorsByTenant
	projectorsByTenant ifNil: [ projectorsByTenant := Dictionary new ].
	^ projectorsByTenant