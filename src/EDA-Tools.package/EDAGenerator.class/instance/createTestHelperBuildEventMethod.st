code generation - test trait
createTestHelperBuildEventMethod
	^ (Smalltalk at: self retrieveTestHelperTraitName asSymbol)
		compile:
			(self isDeleteEvent
				ifTrue: [
					self generateTestHelperBuildDeleteEventMethod
				] ifFalse: [
					self generateTestHelperBuildEventMethod
				])
		classified: self protocol