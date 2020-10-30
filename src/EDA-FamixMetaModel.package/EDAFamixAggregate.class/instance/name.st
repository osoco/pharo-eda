accessing
name
	<MSEProperty: #name type: #String>
	<MSEComment: 'The name of the aggregate.'>
	^ name ifNil: [ name := (self aggregateRoot name , ' Aggregate') ]