accessing
name
	<MSEProperty: #name type: #String>
	<MSEComment: 'The name of the aggregate element.'>
	^ name ifNil: [ name := self aggregateElementClassModel name ]