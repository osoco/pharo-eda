code generation
createRepositorySetupEventStoreClassMethod
	"Not used anymore"
	"| repositoryClass |
	repositoryClass := self class environment at: self retrieveRepositoryClassName asSymbol.
	self
		compile: self generateRepositorySetupEventStoreClassMethodName
		sourceCode: self generateRepositorySetupEventStoreClassMethod
		inClass: repositoryClass class
		classifiedAs: self protocol"