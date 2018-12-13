tests
testRemoveClassLiteralFromMetaClassName
	| instance |
	instance := AbstractEDAGenerator new.
	self assert: (instance removeClassLiteralFromMetaClassName: self class className) equals: self class greaseString