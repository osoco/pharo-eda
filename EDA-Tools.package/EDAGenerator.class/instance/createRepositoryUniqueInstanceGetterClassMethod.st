code generation - repository
createRepositoryUniqueInstanceGetterClassMethod
	| repositoryClass |
	repositoryClass := self class environment at: self retrieveRepositoryClassName asSymbol.
	self
		compileIfDoesNotExist: self generateRepositoryUniqueInstanceGetterClassMethodName
		sourceCode: self generateRepositoryUniqueInstanceGetterClassMethod
		inClass: repositoryClass  class
		classifiedAs: self protocol