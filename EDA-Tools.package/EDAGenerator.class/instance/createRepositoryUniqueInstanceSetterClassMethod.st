code generation - repository
createRepositoryUniqueInstanceSetterClassMethod
	| repositoryClass |
	repositoryClass := self class environment at: self retrieveRepositoryClassName asSymbol.
	self
		compile: self generateRepositoryUniqueInstanceSetterClassMethodName
		sourceCode: self generateRepositoryUniqueInstanceSetterClassMethod
		inClass: repositoryClass class
		classifiedAs: self protocol