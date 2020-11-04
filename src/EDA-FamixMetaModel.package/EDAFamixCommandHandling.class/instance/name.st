accessing
name
	<MSEProperty: #name type: #String>
	<MSEComment: 'The name of the command handling.'>
	^ name ifNil: [ name := self handlerMethod name, '(', self aggregate name, '->', self command name, ')' ]