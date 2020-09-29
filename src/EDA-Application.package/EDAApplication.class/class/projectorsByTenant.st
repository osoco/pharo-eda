accessing
projectorsByTenant
	| result |
	result := projectorsByTenant.
	result ifNil: [ result := Dictionary new. projectorsByTenant := result ].
	^ result