tests
testToDotSeparated
	| instance |
	instance := AbstractEDAGenerator new.
	self assert: (instance upcasedToDotSeparated: 'CREATE_ROUND') equals: 'create.round'