helper
retrieveAttributesFrom: dict
	| vars body |
	body := dict at: #body.
	vars := body keys asSortedCollection.
	^ vars