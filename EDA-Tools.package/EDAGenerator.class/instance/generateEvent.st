api
generateEvent
	Transcript print: 'Generating: Event'; cr.
	self createEventClass.
	self createEventClassAccessors.
	self createEventClassBuilderMethod.
	self createEventClassEqualsMethod.
	self createEventClassHashMethod