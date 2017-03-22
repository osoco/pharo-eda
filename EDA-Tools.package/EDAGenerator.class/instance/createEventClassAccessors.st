compilation
createEventClassAccessors
	| eventClass |
	eventClass := self retrieveEventClassName asSymbol.
	(self generateAccessorsFor: (self retrieveEventAttributesBut: EDAGenerator skippedEventAttributes))
		associationsDo: [ :assoc |
			self
				compileIfDoesNotExist: assoc key
				sourceCode: assoc value
				inClass: eventClass asClass
				classifiedAs: #accessing ]