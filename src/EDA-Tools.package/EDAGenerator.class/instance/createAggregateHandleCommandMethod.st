code generation - aggregate
createAggregateHandleCommandMethod
	| result |
	result :=
		self isDeleteCommand ifTrue: [
			nil
		] ifFalse: [
			self
				compile: self generateAggregateHandleCommandMethodName
				sourceCode: self generateAggregateHandleCommandMethod
				inClass: (self class environment at: (self appName , self aggregate capitalized) asSymbol)
				classifiedAs: self protocol
		].
	^ result