code generation
generateAggregateApplyEventVersionMethodName
	^ 'apply' , (self toCamelCase: self eventName) capitalized , 'v' , (self version greaseString) , ':'