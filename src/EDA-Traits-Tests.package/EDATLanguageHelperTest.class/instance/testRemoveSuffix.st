tests
testRemoveSuffix
	self assert: (self removeSuffix: 'TYPE' from: 'SKILL_TYPE') equals: 'SKILL_'.
	self assert: (self removeSuffix: ':8080' from: 'http://server:8080') equals: 'http://server'