handling
delegateHandlingOfCommand: aCommand toAggregate: anAggregateRoot
	aCommand isCreate
		ifTrue: [ anAggregateRoot class checkTenantOfCommandIsValid: aCommand ]
		ifFalse: [ anAggregateRoot class
				checkTenantOfCommand: aCommand 
				matches: anAggregateRoot  ].
	^ self invokeMethodHandlerWith: aCommand on: anAggregateRoot