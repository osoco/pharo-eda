code generation
generateDomainTestMethod
	| method commandAttrs cmdName eventAttrs evtName |
	commandAttrs := self retrieveCommandAttributes.
	eventAttrs := self retrieveEventAttributes.
	cmdName := self toCamelCase: self commandName.
	evtName := self toCamelCase: self eventName.
	method := self generateDomainTestMethodName.
	method := method , '    | command event |' , String cr.
	method := method , '    command := self build' , cmdName , 'SampleCommand.' , String cr.
	method := method , '    event := self build' , evtName , 'SampleEvent: (command commandId).' , String cr.
	method := method , '    self' , String cr.
	method := method , '        givenAggregate: #' , self appName , self aggregate capitalized , String cr.
	method := method , '        withEvents: {}' , String cr.
	method := method , '        whenReceiveCommand: command' , String cr.
	method := method , '        thenEvent: event' , String cr.
	^ method