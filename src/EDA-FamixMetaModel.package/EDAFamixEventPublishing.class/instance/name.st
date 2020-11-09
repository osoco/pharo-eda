accessing
name
	<MSEProperty: #name type: #String>
	<MSEComment: 'The name of the event publishing.'>
	^ name
		ifNil: [ name :=  '(', self aggregate  name , '->'
				, self event name , ')' ]