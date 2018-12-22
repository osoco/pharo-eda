handling
processGeneratedEvents: producedEvents forCommand: aCommand onAggregateRoot: anAggregateRoot
	| message |
	message := ''.
	producedEvents do: [ :event | event aggregateRootVersion: aCommand aggregateRootVersion + 1. message := message , ' ', event class name ].
	self logInfoMessage: 'Produced event(s): ', message greaseString , '.'.
	self flag: #TODO. "TODO: transaction including eventstore and eventbus operations"
	eventStore saveEvents: producedEvents onAggregate: anAggregateRoot.
	self logInfoMessage: 'Projecting events...'.
	(EDACompositeProjector withAllProjectorsAndEventStore: eventStore) projectFilteredEvents: producedEvents.
	self logInfoMessage: 'Done'.
	^ producedEvents
