bdd
generatedEvent: frame matchesRegex: eventMessageRegex
	| command body |
	command := frame command.
	body := frame body.
	self assert: command equals: #MESSAGE.
	self assertEvent: body matchesEventRegex: eventMessageRegex