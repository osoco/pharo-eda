tests
testRetrieveMaxVersion
	| instance tempFolder commandFolder |
	instance := AbstractEDAGenerator new.
	tempFolder := (FileSystem workingDirectory / '.test-contracts') nextVersion createDirectory.
	commandFolder := tempFolder / 'commands' / 'v599'.
	commandFolder parent createDirectory.
	commandFolder createDirectory.
	instance commandFile: commandFolder / 'sample.command.example.json'.
	[ self assert: instance retrieveMaxVersion equals: 599 ]
		ensure: [ commandFolder delete. commandFolder parent delete. tempFolder delete ]