code generation
generateHandlerMethod
	| result commandClass |
	commandClass := self retrieveCommandClassName asSymbol.
	result := self generateHandlerMethodNameWithArg: 'aCommand' , String cr.
	result := result , '    <useAsCommandHandlerFor: #' , commandClass , '>' , String cr.
	result := result , '    ^ ' , appName , (self toCamelCase: self retrieveEventName) , String cr.
	result := result , '        ' , (self generateEventClassBuilderMethodNameWithCommandArg: 'aCommand commandId' andBlock: [ :attr | 'aCommand ' , attr ]) , String cr.
	^ result