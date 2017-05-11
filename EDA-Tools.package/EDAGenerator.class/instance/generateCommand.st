api
generateCommand
	Transcript print: 'Generating: Command'; cr.

	self createCommandClass.
	self createCommandClassAccessors.
	self createCommandClassBuilderMethod.
	self createCommandClassEqualsMethod.
	self createCommandClassHashMethod