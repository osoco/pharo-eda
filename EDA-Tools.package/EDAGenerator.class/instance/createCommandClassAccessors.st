code generation - command
createCommandClassAccessors
	| commandClass |
	commandClass := self class environment at: self retrieveCommandClassName asSymbol.
	(self
		generateAccessorsFor: commandClass
		attributes: (self allAttributesOf: commandClass including: (self retrieveCommandAttributesBut: self class skippedCommandAttributes)))
		associationsDo: [ :assoc | 
			self
				compile: assoc key
				sourceCode: assoc value
				inClass: commandClass
				classifiedAs: self protocol ]