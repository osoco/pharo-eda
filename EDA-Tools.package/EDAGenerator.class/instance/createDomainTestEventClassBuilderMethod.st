compilation
createDomainTestEventClassBuilderMethod
	| methodAssoc |
	methodAssoc := self generateDomainTestEventClassBuilderMethod associations first.
	^ self
		compile: methodAssoc key
		sourceCode: methodAssoc value
		inClass: (self appName , 'Test' , (self toCamelCase: self retrieveEventName)) asSymbol asClass class
		classifiedAs: 'instance creation' asSymbol