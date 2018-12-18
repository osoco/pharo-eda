test
testRetrieveAggregateFromExistingAggregateMethod
	| generator directory |
	generator := ATSGenerator new.
	directory := FileSystem workingDirectory / 'contracts' / 'BBVA-ATS' / 'v1'.
	directory := FileSystem workingDirectory / 'contracts' / 'BBVA-ATS' / 'v1'.
	"self retrieveAggregateFromExistingAggregateMethodFor: directory / 'commands' / 'create.round.example.json' shouldBe: 'Round'."
	self retrieveAggregateFromExistingAggregateMethodFor: directory / 'commands' / 'create.contest.example.json' shouldBe: 'Contest'