code generation - aggregate
generateApplyEventMethodName
	^ 'apply' , (self toCamelCase: self retrieveEventName) capitalized , ':'