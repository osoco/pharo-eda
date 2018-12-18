tests
testNounInSingular
	self assert: (self nounInSingular: 'applicants') equals: 'applicant'.
	self assert: (self nounInSingular: 'applicant') equals: 'applicant'.
	self assert: (self nounInSingular: 'contests') equals: 'contest'.
	self assert: (self nounInSingular: 'contest') equals: 'contest'.
	self assert: (self nounInSingular: 'countries') equals: 'country'.
	self assert: (self nounInSingular: 'country') equals: 'country'.
	self assert: (self nounInSingular: 'evaluations') equals: 'evaluation'.
	self assert: (self nounInSingular: 'evaluation') equals: 'evaluation'.
	self assert: (self nounInSingular: 'evaluators') equals: 'evaluator'.
	self assert: (self nounInSingular: 'evaluator') equals: 'evaluator'.
	self assert: (self nounInSingular: 'rounds') equals: 'round'.
	self assert: (self nounInSingular: 'round') equals: 'round'.
	self assert: (self nounInSingular: 'skilltypes') equals: 'skilltype'.
	self assert: (self nounInSingular: 'skilltype') equals: 'skilltype'.
	self assert: (self nounInSingular: 'buses') equals: 'bus'.
	self assert: (self nounInSingular: 'bus') equals: 'bus'