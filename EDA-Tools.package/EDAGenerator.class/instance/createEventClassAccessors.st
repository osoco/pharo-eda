code generation - event
createEventClassAccessors
	| eventClass |
	eventClass := self class environment at: self retrieveEventClassName asSymbol.
	(self generateAccessorsFor: eventClass attributes: (self allAttributesOf: eventClass including: (self retrieveEventAttributesBut: self class skippedEventAttributes)))
		associationsDo: [ :assoc |
			self
				compileIfDoesNotExist: assoc key
				sourceCode: assoc value
				inClass: eventClass
				classifiedAs: self protocol ]