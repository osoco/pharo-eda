accessing
name
	<MSEProperty: #name type: #String>
	<MSEComment: 'The name of the command handling.'>
	^ name
		ifNil: [ name := self handlerMethod name , '(' , self command name , '->'
				, self aggregate name , ')' ]