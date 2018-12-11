tests
testRetrieveVersion
	| instance |
	instance := AbstractEDAGenerator new.
	instance commandFile: FileSystem workingDirectory / 'contracts' / 'v5' / 'sample.example.json'.
	self assert: instance retrieveVersion equals: 5.
	instance commandFile: FileSystem workingDirectory / 'contracts' / 'v46' / 'sample.example.json'.
	self assert: instance retrieveVersion equals: 46