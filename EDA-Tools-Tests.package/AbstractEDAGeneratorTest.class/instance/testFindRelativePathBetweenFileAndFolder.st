tests
testFindRelativePathBetweenFileAndFolder
	| instance |
	instance := AbstractEDAGenerator new.
	self
		assert: (instance findRelativePathBetweenFile: FileSystem disk workingDirectory / 'test.txt' andFolder: FileSystem disk workingDirectory)
		equals: #() asOrderedCollection.
	self
		assert:
			(instance
				findRelativePathBetweenFile: FileSystem disk workingDirectory / 'contracts' / 'commands' / 'v1' / 'create.tag.example.json'
				andFolder: FileSystem disk workingDirectory)
		equals: #('contracts' 'commands' 'v1') asOrderedCollection