code generation
generateReadCommandFromFileTestHelperMethod
	^ self
		generateReadFromFileTestHelperMethod: self generateReadCommandFromFileTestHelperMethodName
		for: self commandName
		ofType: 'commands'