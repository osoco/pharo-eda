test
testRetrieveAggregateFromFileName
	| generator directory |
	generator := ATSGenerator new.
	directory := FileSystem workingDirectory / 'contracts' / 'BBVA-ATS' / 'v1'.
	self assert: (generator retrieveAggregateFromFileName: directory / 'create.round.example.json') equals: 'Round'.
	self assert: (generator retrieveAggregateFromFileName: directory / 'create.contest.example.json') equals: 'Contest'.
	"self assert: (generator retrieveAggregateFromFileName: directory / 'applicant.updated.example.json') equals: 'Applicant'"