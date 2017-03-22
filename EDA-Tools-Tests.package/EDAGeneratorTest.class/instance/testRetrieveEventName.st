test
testRetrieveEventName
	| instance |
	instance := EDAGenerator new commandName: 'UPDATE_ROUND'.
	self assert: instance retrieveEventName equals: 'ROUND_UPDATED'.
	instance := EDAGenerator new commandName: 'GENERATE_NEW_TOKEN'.
	self assert: instance retrieveEventName equals: 'NEW_TOKEN_GENERATED'