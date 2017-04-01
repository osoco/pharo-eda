code generation - test trait
createReadCommandFromFileTestHelperMethod
	^ (Smalltalk at: self retrieveTestHelperTraitName asSymbol)
		compile: self generateReadCommandFromFileTestHelperMethod
		classified: #helper