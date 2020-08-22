code generation
createTestHelperBuildEventFromArbitraryFileMethod
	self isDeletedEvent
		ifFalse: [
			(Smalltalk at: self retrieveTestHelperTraitName asSymbol)
			compile:	self generateTestHelperBuildEventFromArbitraryFileMethod
			classified: self protocol
		]