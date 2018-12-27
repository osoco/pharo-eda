code generation
createRepositoryClassAccessors
	| repositoryClass |
	repositoryClass := self class environment at: self retrieveRepositoryClassName asSymbol.
	(self generateAccessorsFor: repositoryClass attributes: (self allAttributesOf: repositoryClass))
		associationsDo: [ :assoc | 
			self
				compile: assoc key
				sourceCode: assoc value
				inClass: repositoryClass
				classifiedAs: self protocol ]