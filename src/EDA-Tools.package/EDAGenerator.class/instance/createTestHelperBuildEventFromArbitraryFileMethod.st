code generation - test trait
createTestHelperBuildEventFromArbitraryFileMethod
	self isDeleteEvent
		ifFalse: [
			(Smalltalk at: self retrieveTestHelperTraitName asSymbol)
			compile:	self generateTestHelperBuildEventFromArbitraryFileMethod
			classified: self protocol
		]