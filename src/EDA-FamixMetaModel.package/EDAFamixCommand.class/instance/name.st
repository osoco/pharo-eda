accessing
name
	<MSEProperty: #name type: #String>
	<MSEComment: 'The name of the command.'>
	^ name ifNil: [ name := self command name , ' Command' ]