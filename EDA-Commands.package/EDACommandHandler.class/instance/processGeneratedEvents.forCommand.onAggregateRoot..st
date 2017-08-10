handling
processGeneratedEvents: producedEvents forCommand: aCommand onAggregateRoot: anAggregateRoot
	| events |
	events := 
		(producedEvents isKindOf: OrderedCollection)
			ifTrue: [ producedEvents ]
			ifFalse: [
				(producedEvents isKindOf: Array)
					ifTrue: [ OrderedCollection withAll: producedEvents ]
					ifFalse: [ OrderedCollection with: producedEvents ] ].
	events do: [ :event | event aggregateRootVersion: aCommand aggregateRootVersion + 1 ].
	Transcript print: 'Produced event(s):'.
	events do: [ :event | Transcript print: ' '; print: event class name ].
	Transcript cr.
	self flag: #TODO. "TODO: transaction including eventstore and eventbus operations"
	eventStore saveEvents: events onAggregate: anAggregateRoot.
	Transcript print: 'Projecting events...'.
	EDAProjectionProcessor projectEvents: events.
	Transcript print: ' done'; cr.
