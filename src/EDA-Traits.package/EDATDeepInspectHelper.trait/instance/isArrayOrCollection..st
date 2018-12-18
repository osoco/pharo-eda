comparing
isArrayOrCollection: aVar
	^ (aVar class = Array) or: [ aVar isKindOf: OrderedCollection ]
