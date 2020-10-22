handling
delegateHandlingOfCommand: aCommand toAggregate: anAggregateRoot
	aCommand isCreate
		ifTrue: [ anAggregateRoot class checkTenantOfCommandIsValid: aCommand ]
		ifFalse: [ anAggregateRoot class
				checkTenantOfCommand: aCommand tenant
				matches: anAggregateRoot tenant ].
	^ self invokeMethodHandlerWith: aCommand on: anAggregateRoot