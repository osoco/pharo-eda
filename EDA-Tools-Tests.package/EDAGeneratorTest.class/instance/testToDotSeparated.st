test
testToDotSeparated
	| instance |
	instance := EDAGenerator new.
	self assert: (instance upcasedToDotSeparated: 'CREATE_ROUND') equals: 'create.round'