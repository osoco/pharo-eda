accessing
aggregate: anAggregate
	
	aggregate := FMMultivalueLink
		on: self
		update: #commandHandlings
		from: self aggregate
		to: anAggregate