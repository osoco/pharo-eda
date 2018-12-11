api
generateCommand
	self isDeleteCommand
		ifTrue: [ ^ self ].
	self createCommandClass.
	self createCommandClassAccessors.
	self createCommandClassBuilderMethod.
	self createCommandClassEqualsMethod.
	self createCommandClassHashMethod.
	self createCommandClassRetrieveAggregateRootClassMethod