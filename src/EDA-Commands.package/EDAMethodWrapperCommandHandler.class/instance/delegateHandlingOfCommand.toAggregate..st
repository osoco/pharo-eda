handling
delegateHandlingOfCommand: aCommand toAggregate: anAggregateRoot
	^ self invokeMethodHandlerWith: aCommand on: anAggregateRoot
