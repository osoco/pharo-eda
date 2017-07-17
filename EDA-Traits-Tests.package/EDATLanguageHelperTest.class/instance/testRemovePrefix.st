tests
testRemovePrefix
	self assert: (self removePrefix: 'SKILL' from: 'SKILL_TYPE') equals: '_TYPE'.
	self assert: (self removePrefix: 'file://' from: 'file:///home/whatever') equals: '/home/whatever'