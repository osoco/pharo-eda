initialization
initialize
	self generatorClasses: ((EDAGenerator allSubclasses reject: [ :cls | cls = self class ]) asSortedCollection: [ :first :second | first shouldRunAfter: second ])