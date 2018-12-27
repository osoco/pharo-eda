protected
groupEventsByAggregateRootId: events
	| result |
	result := Dictionary new.
	events
		do: [ :evt | 
			| list id |
			id := self aggregateIdFor: evt.
			list := result at: id ifAbsent: [ OrderedCollection new ].
			list add: evt.
			result at: id put: list ].
	^ result