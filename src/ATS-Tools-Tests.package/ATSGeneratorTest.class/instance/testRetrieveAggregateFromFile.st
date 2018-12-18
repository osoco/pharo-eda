test
testRetrieveAggregateFromFile
	| generator directory |
	generator := ATSGenerator new.
	directory := FileSystem workingDirectory / 'contracts' / 'BBVA-ATS' / 'v1'.
	self assert: (generator retrieveAggregateFromFile: directory / 'commands' / 'create.round.example.json') equals: 'Round'.
	self assert: (generator retrieveAggregateFromFile: directory / 'commands' / 'create.contest.example.json') equals: 'Contest'.
	self assert: (generator retrieveAggregateFromFile: directory / 'commands' / 'assign.application.example.json') equals: 'Evaluation'.
	self assert: (generator retrieveAggregateFromFile: directory / 'events' / 'applicant.updated.example.json') equals: 'Applicant'