code generation - integration test
generateIntegrationTestMethod
	| method commandAttrs cmdName eventAttrs evtName |
	commandAttrs := self retrieveCommandAttributes.
	eventAttrs := self retrieveEventAttributes.
	cmdName := self toCamelCase: self commandName.
	evtName := self toCamelCase: self eventName.
	method := self generateDomainTestMethodName.
	method := method , '    | command event commandMessage eventMessage expectedRoutingKey |'
		, String cr.
	method := method , '    command := self build' , cmdName , 'SampleCommand.' , String cr.
	method := method , '    event := self build' , evtName , 'SampleEvent: (command commandId).'
		, String cr.
	method := method , '    commandMessage := self read' , cmdName , 'FromFile.' , String cr.
	method := method , '    eventMessage := self read' , evtName , 'FromFile.' , String cr.
	method := method , '    expectedRoutingKey := ' , $' asString
		, (self upcasedToDotSeparated: self eventName) , $' asString , '.' , String cr.
	method := method , '    self' , String cr.
	method := method , '        givenPreviousEvents: {}' , String cr.
	method := method , '        whenReceiveCommandMessage: commandMessage' , String cr.
	method := method , '        thenStoreEvent: event' , String cr.
	method := method , '        andPublishEventMessage: eventMessage' , String cr.
	method := method , '        withRoutingKey: expectedRoutingKey' , String cr.
	^ method