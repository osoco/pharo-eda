bdd
generatedEvent: frame matchesRegex: eventMessageRegex
	self assert: frame command equals: #MESSAGE.
	self assert: (self event: frame body matchesEventRegex: eventMessageRegex)