code generation - aggregate
generateAggregateApplyEventMethodNameWithArg: arg
	^ 'apply' , (self toCamelCase: self eventName) capitalized , ': ' , arg