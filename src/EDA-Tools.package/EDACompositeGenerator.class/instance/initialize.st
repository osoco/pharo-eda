initialization
initialize
	self generatorClasses: (EDAGenerator allSubclasses reject: [ :cls | cls = self class ])