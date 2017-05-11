api
generateAggregate
	Transcript
		print: 'Generating: Aggregate';
		cr.
	self createAggregateClass.
	self createAggregateHandleCommandMethod.
	self createAggregateApplyEventMethod.
	self createAggregateClassAccessors.
	self createAggregateClassEqualsMethod.
	self createAggregateClassHashMethod.
	self createAggregateRetrieveRepositoryMethod