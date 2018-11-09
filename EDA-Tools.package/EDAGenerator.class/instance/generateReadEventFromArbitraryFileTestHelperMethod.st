code generation - test trait
generateReadEventFromArbitraryFileTestHelperMethod
	^ self
		generateReadFromFileTestHelperMethod: self generateReadEventFromArbitraryFileTestHelperMethodName
		for: self eventName
		ofType: 'events'