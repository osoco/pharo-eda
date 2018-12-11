tests
testCommandNameFor
	self assert: (self commandNameFor: (FileSystem workingDirectory / 'application.created') basename) equals: 'create.application'