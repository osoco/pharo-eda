tests
testNounInPlural
	self assert: (self nounInPlural: 'applicant') equals: 'applicants'.
	self assert: (self nounInPlural: 'applicants') equals: 'applicants'.
	self assert: (self nounInPlural: 'contest') equals: 'contests'.
	self assert: (self nounInPlural: 'contests') equals: 'contests'.
	self assert: (self nounInPlural: 'country') equals: 'countries'.
	self assert: (self nounInPlural: 'countries') equals: 'countries'.
	self assert: (self nounInPlural: 'evaluation') equals: 'evaluations'.
	self assert: (self nounInPlural: 'evaluations') equals: 'evaluations'.
	self assert: (self nounInPlural: 'evaluator') equals: 'evaluators'.
	self assert: (self nounInPlural: 'evaluators') equals: 'evaluators'.
	self assert: (self nounInPlural: 'round') equals: 'rounds'.
	self assert: (self nounInPlural: 'rounds') equals: 'rounds'.
	self assert: (self nounInPlural: 'skilltype') equals: 'skilltypes'.
	self assert: (self nounInPlural: 'skilltypes') equals: 'skilltypes'.
	self assert: (self nounInPlural: 'bus') equals: 'buses'.
	self assert: (self nounInPlural: 'buses') equals: 'buses'