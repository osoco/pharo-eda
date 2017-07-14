handling
handle: aCommand withErrorStrategy: strategy
	| events aggregateRoot producedEvents |
	[
		Transcript
			print: 'Retrieving events for '; print: self aggregateRootClass name;	print: ' matching '; print: aCommand aggregateSelectionCriteria greaseString; print: $.; cr.
		events :=
			eventStore
				findEventsOfAggregate: self aggregateRootClass
				whereCriteria: aCommand aggregateSelectionCriteria.
		Transcript print: 'Events retrieved (' , events size greaseString , '):'.
		events do: [ :e | Transcript print: ' '; print: e class name ].
		Transcript cr.
		aggregateRoot := self aggregateRootClass new.
		Transcript print: 'Applying '; print: events size greaseString; print: ' event(s) to an empty '; print: aggregateRootClass greaseString; print: $.; cr.
		aggregateRoot applyEvents: events.
		"TODO: Compare the version number in the command with the current 
		version number of the aggregate and, if they are different, it can 
		raise a concurrency error and reject the change".
		aggregateRoot version = aCommand aggregateRootVersion
			ifFalse: [
				Transcript
					print: 'WARNING: aggregate root''s version (';
					print: aggregateRoot version;
					print: ') does not match command''s (';
					print: aCommand aggregateRootVersion; print: ').';
					cr
			].
		Transcript
			print: 'Handling command ';
			print: aCommand class name;
			cr.
		producedEvents := self invokeMethodHandlerWith: aCommand on: aggregateRoot.
		(producedEvents isKindOf: OrderedCollection)
			ifFalse: [ producedEvents := OrderedCollection newFrom: {producedEvents} ].
		producedEvents
			do: [ :event | event aggregateRootVersion: aCommand aggregateRootVersion + 1 ].
		Transcript print: 'Produced event(s):'.
		producedEvents do: [ :event | Transcript print: ' '; print: event class name ].
		Transcript cr.
		self flag: #TODO. "TODO: transaction including eventstore and eventbus operations"
		eventStore saveEvents: producedEvents onAggregate: aggregateRoot.
		
		Transcript print: 'Projecting events...'.
		EDAProjectionProcessor projectEvents: producedEvents.
		Transcript print: ' done'; cr.
	]
	on: Error
	do: [ :exception | 
		| errorHandler |
		errorHandler :=
			(self class environment at: strategy asSymbol) new
				context:
					(Dictionary
						newFrom:
							{(#producedEvents -> producedEvents).
							(#context -> thisContext)}).
			producedEvents := errorHandler handleError: exception
	].
	eventBus produceEvents: producedEvents.
	^ self