code generation
generateAggregateRetrieveRepositoryMethodName
	^ 'retrieve' , (self toCamelCase: self aggregate) capitalized , 'Repository'