helper
retrieveAttributeValue: attr in: dict
	| result body |
	body := dict at: #body.
	result := body at: attr ifAbsent: [ result := '' ].
	^ result