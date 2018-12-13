helper
retrieveAggregateFromAggregateKey: json
	| result aux |
	aux := (json at: #meta) at: #aggregate ifAbsent: [ nil ].
	result := aux ifNil: [ nil ] ifNotNil: [ :arg | aux asCamelCase ].
	^ result