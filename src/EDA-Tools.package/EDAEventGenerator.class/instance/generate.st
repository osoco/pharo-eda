api
generate
	self logDebugMessage: '** Generating command for ' , self eventName greaseString , ', version ' , self version greaseString.
	self createEventClass.
	self createEventClassAccessors.
	self createEventClassBuilderMethod.
	self createEventClassEqualsMethod.
	self createEventClassHashMethod.
	self createEventClassAggregateRootClassMethod