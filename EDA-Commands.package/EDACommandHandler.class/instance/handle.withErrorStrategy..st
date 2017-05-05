handling
handle: aCommand withErrorStrategy: strategy
	| events aggregateRoot producedEvents |
	[
	Transcript
		print: 'Retrieving events for ' , self aggregateRootClass name;
		cr;
		flush.
	events := eventStore
		findEventsOfAggregate: self aggregateRootClass
		whereCriteria: aCommand aggregateSelectionCriteria.
	Transcript print: 'Events retrieved (' , events size printString , '):'.
	events do: [ :e | Transcript print: ' ' , e class name ].
	Transcript
		cr;
		flush.
	aggregateRoot := self aggregateRootClass new.
	aggregateRoot applyEvents: events.
	"TODO: Compare the version number in the command with the current 
	version number of the aggregate and, if they are different, it can 
	raise a concurrency error and reject the change"
	Transcript
		print: 'Handling command ' , aCommand class name;
		cr;
		flush.
	producedEvents := self invokeMethodHandlerWith: aCommand on: aggregateRoot.
	(producedEvents isKindOf: OrderedCollection)
		ifFalse: [ producedEvents := OrderedCollection newFrom: {producedEvents} ].
	producedEvents
		do: [ :event | event aggregateRootVersion: aCommand aggregateRootVersion + 1 ].
	Transcript print: 'Produced event(s):'.
	producedEvents do: [ :event | Transcript print: ' ' , event class name ].
	Transcript
		cr;
		flush.
	Transcript
		print: 'Projecting events...';
		cr;
		flush.
	EDAProjectionProcessor projectEvents: producedEvents.
	Transcript
		print: 'Events projected';
		cr;
		flush.
	"TODO: transaction including eventstore and eventbus operations"
	eventStore saveEvents: producedEvents onAggregate: aggregateRoot ]
		on: Error
		do: [ :exception | 
			| errorHandler |
			errorHandler := (self class environment at: strategy) new
				context:
					(Dictionary
						newFrom:
							{(#producedEvents -> producedEvents).
							(#context -> thisContext)}).
			producedEvents := errorHandler handleError: exception ].
	Transcript
		print: 'Publishing event(s)';
		cr;
		flush.
	eventBus produceEvents: producedEvents.
	Transcript
		print: 'Generated event(s) published';
		cr;
		flush.
	^ self