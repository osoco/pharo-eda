code generation - command
createCommandAccessors
	| commandClass |
	commandClass := self retrieveCommandClassName asSymbol.
	(self generateAccessorsFor: (self retrieveCommandAttributesBut: EDAGenerator skippedCommandAttributes))
		associationsDo: [ :assoc |
			self
				compileIfDoesNotExist: assoc key
				sourceCode: assoc value
				inClass: commandClass asClass
				classifiedAs: #accessing ]