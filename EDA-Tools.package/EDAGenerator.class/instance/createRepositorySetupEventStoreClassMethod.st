code generation - repository
createRepositorySetupEventStoreClassMethod
	| repositoryClass |
	repositoryClass := self class environment at: self retrieveRepositoryClassName asSymbol.
	self
		compileIfDoesNotExist: self generateRepositorySetupEventStoreClassMethodName
		sourceCode: self generateRepositorySetupEventStoreClassMethod
		inClass: repositoryClass class
		classifiedAs: self protocol