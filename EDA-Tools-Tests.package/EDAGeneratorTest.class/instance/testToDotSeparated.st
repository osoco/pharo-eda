test
testToDotSeparated
	| instance |
	instance := EDAGenerator new.
	self assert: (instance toDotSeparated: 'CREATE_ROUND') equals: 'create.round'