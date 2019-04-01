code generation
retrieveDomainTestEventClassName
	^ (self appName , 'Test' , (self toCamelCase: self eventName)) asSymbol