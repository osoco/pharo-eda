test
testIsAggregate
	| generator |
	generator := ATSGenerator new.
	self assert: (generator isAggregate: 'Round').
	self assert: (generator isAggregate: 'Contest').
	self assert: (generator isAggregate: 'Applicant')