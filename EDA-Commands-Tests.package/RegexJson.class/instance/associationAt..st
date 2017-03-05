comparing
associationAt: key
	^ self associationAt: key ifAbsent: [ ^ (#key -> '(.*)') ]