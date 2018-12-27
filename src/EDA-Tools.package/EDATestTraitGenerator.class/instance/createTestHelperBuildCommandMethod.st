code generation
createTestHelperBuildCommandMethod
	^ (Smalltalk at: self retrieveTestHelperTraitName asSymbol)
		compile:	self generateTestHelperBuildCommandMethod
		classified: self protocol
			
