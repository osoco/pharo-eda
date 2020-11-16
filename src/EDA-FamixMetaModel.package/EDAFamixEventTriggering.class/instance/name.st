accessing
name
	<MSEProperty: #name type: #String>
	<MSEComment: 'The name of the event triggering.'>
	^ name
		ifNil:
			[ name := '(' , self command name , '->' , self event name , ')' ]