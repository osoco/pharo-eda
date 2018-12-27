api
generate
	self logDebugMessage: '** Generating aggregate for ' , self aggregate greaseString , ', version ' , self version greaseString.
	self createAggregateClass.
	self createAggregateHandleCommandMethod.
	self createAggregateApplyEventVersionMethod.
	self createAggregateClassAccessors.
	self createAggregateClassEqualsMethod.
	self createAggregateClassHashMethod.
	self createAggregateRetrieveRepositoryMethod