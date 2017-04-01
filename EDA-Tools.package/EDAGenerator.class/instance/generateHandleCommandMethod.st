code generation - aggregate
generateHandleCommandMethod
	| result commandClass |
	commandClass := self retrieveCommandClassName asSymbol.
	result := self generateHandleCommandMethodNameWithArg: 'aCommand' , String cr.
	result := result , '    <useAsCommandHandlerFor: #' , commandClass , '>' , String cr.
	result := result , '    ^ ' , appName , (self toCamelCase: self retrieveEventName) , String cr.
	result := result , '        ' , (self generateEventBuilderClassMethodNameWithCommandArg: 'aCommand commandId' andBlock: [ :attr | 'aCommand ' , attr ]) , String cr.
	^ result