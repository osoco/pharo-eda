initialization
sortGeneratorClasses: aCollection
	^ (aCollection reject: [ :cls | cls = self class ]) asSortedCollection: [ :first :second | (first shouldRunAfter: second) not ]