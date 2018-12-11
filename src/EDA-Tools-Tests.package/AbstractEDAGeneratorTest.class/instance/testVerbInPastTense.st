tests
testVerbInPastTense
	| instance |
	instance := AbstractEDAGenerator new.
	self assert: (instance verbInPastTense: 'work') equals: 'worked'.
	self assert: (instance verbInPastTense: 'create') equals: 'created'.
	self assert: (instance verbInPastTense: 'submit') equals: 'submitted'.
	self assert: (instance verbInPastTense: 'update') equals: 'updated'.
	self assert: (instance verbInPastTense: 'delay') equals: 'delayed'.
	self assert: (instance verbInPastTense: 'build') equals: 'built'