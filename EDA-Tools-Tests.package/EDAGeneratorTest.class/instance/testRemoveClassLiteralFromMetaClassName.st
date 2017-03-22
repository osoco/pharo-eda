test
testRemoveClassLiteralFromMetaClassName
	| instance |
	instance := EDAGenerator new.
	self
		assert: (instance removeClassLiteralFromMetaClassName: EDAGeneratorTest className)
		equals: #EDAGeneratorTest