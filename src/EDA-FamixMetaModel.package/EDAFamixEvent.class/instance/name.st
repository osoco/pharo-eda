accessing
name
	<MSEProperty: #name type: #String>
	<MSEComment: 'The name of the event.'>
	^ name ifNil: [ name := self event name ]