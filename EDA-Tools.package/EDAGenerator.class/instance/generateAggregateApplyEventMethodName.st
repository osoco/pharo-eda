code generation - aggregate
generateAggregateApplyEventMethodName
	^ 'apply' , (self toCamelCase: self eventName) capitalized , ':'