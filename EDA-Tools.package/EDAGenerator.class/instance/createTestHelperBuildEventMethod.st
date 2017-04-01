code generation - test trait
createTestHelperBuildEventMethod
	^ (Smalltalk at: self retrieveTestHelperTraitName asSymbol) compile: self generateTestHelperBuildEventMethod classified: #helper