code generation
createEventClassAccessors
	| eventClass |
	eventClass := self class environment at: self retrieveEventClassName asSymbol.
	(self generateAccessorsFor: eventClass attributes:(self retrieveEventAttributesBut: self class skippedEventAttributes))
		associationsDo: [ :assoc | 
			self
				compile: assoc key
				sourceCode: assoc value
				inClass: eventClass
				classifiedAs: self protocol ]