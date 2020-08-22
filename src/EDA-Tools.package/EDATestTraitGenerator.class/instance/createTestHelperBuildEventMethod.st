code generation
createTestHelperBuildEventMethod
	^ (Smalltalk at: self retrieveTestHelperTraitName asSymbol)
		compile:
			(self isDeletedEvent
				ifTrue: [
					self generateTestHelperBuildDeleteEventMethod
				] ifFalse: [
					self generateTestHelperBuildEventMethod
				])
		classified: self protocol