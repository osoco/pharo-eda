accessing
version
	| result |
	result := version.
	result
		ifNil: [ result := 1.
			self version: result ].
	^ result