code generation
createAggregateApplyEventVersionMethod
	| result |
	result := self isDeleteEvent
		ifTrue: [ nil ]
		ifFalse: [
			self
				compile: self generateAggregateApplyEventVersionMethodName
				sourceCode: self generateAggregateApplyEventVersionMethod
				inClass:
					(self class environment
						at: (self appName , self aggregate capitalized) asSymbol)
				classifiedAs: self protocol ].
	^ result