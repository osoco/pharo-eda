as yet unclassified
associationAt: key
	^ self associationAt: key ifAbsent: [ ^ key -> '(.*)' ]