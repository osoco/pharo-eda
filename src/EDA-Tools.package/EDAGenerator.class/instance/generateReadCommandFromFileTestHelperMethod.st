code generation - test trait
generateReadCommandFromFileTestHelperMethod
	^ self
		generateReadFromFileTestHelperMethod: self generateReadCommandFromFileTestHelperMethodName
		for: self commandName
		ofType: 'commands'