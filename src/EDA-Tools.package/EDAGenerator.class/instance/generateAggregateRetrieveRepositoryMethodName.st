code generation - aggregate
generateAggregateRetrieveRepositoryMethodName
	^ 'retrieve' , (self toCamelCase: self aggregate) capitalized , 'Repository'