bdd
generatedEvent: frame matchesRegex: eventMessageRegex
	| command body |
	command := frame command.
	body := frame body.
	self assert: command equals: #MESSAGE.
	self assert: (self event: body matchesEventRegex: eventMessageRegex)