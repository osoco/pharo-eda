delegated
createTestEventBuildEventClassMethod
	| method |
	method := self generateTestEventBuildEventClassMethod.
	method
		associationsDo: [ :assoc | 
			^ self
				compile: assoc key
				sourceCode: assoc value
				inClass: self retrieveDomainTestEventClass 
				classifiedAs: self protocol ]