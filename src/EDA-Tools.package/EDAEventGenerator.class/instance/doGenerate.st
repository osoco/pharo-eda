protected
doGenerate
	self createEventClass.
	self createEventClassAccessors.
	self createEventClassBuilderMethod.
	self createEventClassEqualsMethod.
	self createEventClassHashMethod.
	self createEventClassAggregateRootClassMethod