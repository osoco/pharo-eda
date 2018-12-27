code generation
createReadEventFromFileTestHelperMethod
	^ (Smalltalk at: self retrieveTestHelperTraitName asSymbol)
		compile: self generateReadEventFromFileTestHelperMethod
		classified: self protocol