code generation
generateReadEventFromArbitraryFileTestHelperMethod
	^ self
		generateReadFromFileTestHelperMethod: self generateReadEventFromArbitraryFileTestHelperMethodName
		for: self eventName
		ofType: 'events'