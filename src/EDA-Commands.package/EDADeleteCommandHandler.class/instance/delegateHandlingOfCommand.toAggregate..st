handling
delegateHandlingOfCommand: aCommand toAggregate: anAggregateRoot
	aCommand isDelete
		ifTrue: [
			^ anAggregateRoot handleDeleteCommand: aCommand
		] ifFalse: [
			EDAInvalidCommandMessage signal
		]
					
