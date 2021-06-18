Trait {
	#name : #EDATHashHelper,
	#category : #'EDA-Traits'
}

{ #category : #comparing }
EDATHashHelper >> hash [
	^ self class allInstVarNames
		inject: self class greaseString hash
		into: [ :var :selector | var hash bitXor: (selector value: self) hash ]
]
