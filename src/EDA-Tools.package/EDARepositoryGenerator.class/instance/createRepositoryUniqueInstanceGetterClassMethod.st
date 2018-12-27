code generation
createRepositoryUniqueInstanceGetterClassMethod
	"Not used anymore"
	"| repositoryClass |
	repositoryClass := self class environment at: self retrieveRepositoryClassName asSymbol.
	self
		compile: self generateRepositoryUniqueInstanceGetterClassMethodName
		sourceCode: self generateRepositoryUniqueInstanceGetterClassMethod
		inClass: repositoryClass class
		classifiedAs: self protocol"