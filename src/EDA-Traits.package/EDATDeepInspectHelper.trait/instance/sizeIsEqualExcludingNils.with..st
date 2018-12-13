comparing
sizeIsEqualExcludingNils: anArrayOrCollection with: anotherArrayOrCollection
	^ (anArrayOrCollection size = anotherArrayOrCollection size)
		or: [   (anArrayOrCollection reject: [ :v | v isNil ]) size
				= (anotherArrayOrCollection reject: [ :v | v isNil ]) size ]