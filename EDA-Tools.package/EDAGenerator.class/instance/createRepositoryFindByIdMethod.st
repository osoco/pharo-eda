code generation - repository
createRepositoryFindByIdMethod
	| repositoryClass |
	repositoryClass := self class environment at: self retrieveRepositoryClassName asSymbol.
	self
		compile: self generateRepositoryFindByIdMethodName
		sourceCode: self generateRepositoryFindByIdMethod
		inClass: repositoryClass
		classifiedAs: self protocol