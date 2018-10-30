handling
processGeneratedEvents: producedEvents forCommand: aCommand onAggregateRoot: anAggregateRoot
	| events message |
	events := 
		(producedEvents isKindOf: OrderedCollection)
			ifTrue: [ producedEvents ]
			ifFalse: [
				(producedEvents isKindOf: Array)
					ifTrue: [ OrderedCollection withAll: producedEvents ]
					ifFalse: [ OrderedCollection with: producedEvents ] ].
	message := ''.
	events do: [ :event | event aggregateRootVersion: aCommand aggregateRootVersion + 1. message := message , ' ', event class name ].
	self logInfoMessage: 'Produced event(s): ', message greaseString , '.'.
	self flag: #TODO. "TODO: transaction including eventstore and eventbus operations"
	eventStore saveEvents: events onAggregate: anAggregateRoot.
	self logInfoMessage: 'Projecting events...'.
	EDAProjectionProcessor projectEvents: events.
	self logInfoMessage: 'Done'.
	^ events
