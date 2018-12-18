code generation - test trait
createReadEventFromFileTestHelperMethod
	^ (Smalltalk at: self retrieveTestHelperTraitName asSymbol)
		compile: self generateReadEventFromFileTestHelperMethod
		classified: self protocol