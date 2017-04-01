api
generateAggregate
	self createAggregate.
	self createAggregateHandleCommandMethod.
	self createAggregateApplyEventMethod.
	self createAggregateAccessors.
	self createAggregateEqualsMethod.
	self createAggregateHashMethod