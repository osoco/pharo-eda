code generation
createAggregateApplyEventVersionMethod
	| result |
	result := self isDeletedEvent
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