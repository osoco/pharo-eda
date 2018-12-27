code generation
generateAggregateApplyEventVersionMethodNameWithArg: arg
	^ 'apply' , (self toCamelCase: self eventName) capitalized , 'v' , (self version greaseString) , ':' , arg