api
generate
	self isDeleteCommand
		ifTrue: [ ^ self ].
	self logDebugMessage: '** Generating command for ' , self commandName greaseString , ', version ' , self version greaseString.
	self createCommandClass.
	self createCommandClassAccessors.
	self createCommandClassBuilderMethod.
	self createCommandClassEqualsMethod.
	self createCommandClassHashMethod.
	self createCommandClassRetrieveAggregateRootClassMethod