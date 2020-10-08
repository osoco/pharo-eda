accessing
routingKey
	^ EDASourceCodeHelperStub new
		camelCaseToDotSeparated: (EDAMessageSerializer nameWithoutPrefixForMessageClass: self class)