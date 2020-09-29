handling
delegateHandlingOfCommand: aCommand toAggregate: anAggregateRoot
	aCommand isCreate
		ifTrue: [ anAggregateRoot class checkTenantIsValid: aCommand tenant ]
		ifFalse: [ anAggregateRoot class checkTenantOfCommand: aCommand tenant matches: anAggregateRoot  tenant ].
	^ self invokeMethodHandlerWith: aCommand on: anAggregateRoot