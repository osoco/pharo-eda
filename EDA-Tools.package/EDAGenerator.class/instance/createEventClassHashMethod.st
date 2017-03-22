compilation
createEventClassHashMethod
	^ self compile: 'hash' sourceCode: (self generateHashMethodFor: self retrieveEventAttributes) inClass: (self retrieveEventClassName asSymbol asClass) classifiedAs: #hash