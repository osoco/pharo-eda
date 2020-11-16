as yet unclassified
methodModelFor: aMethod
	^ self allModelMethods
		detect: [ :methodModel | methodModel compiledMethod = aMethod ]