api
generateEvent
	self isDeleteCommand
		ifTrue: [ ^ self ].
	self createEventClass.
	self createEventClassAccessors.
	self createEventClassBuilderMethod.
	self createEventClassEqualsMethod.
	self createEventClassHashMethod.
	self createEventClassInitializeMethod