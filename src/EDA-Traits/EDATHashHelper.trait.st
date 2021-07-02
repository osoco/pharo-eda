Trait {
	#name : #EDATHashHelper,
	#category : #'EDA-Traits'
}

{ #category : #comparing }
EDATHashHelper >> hash [
	^ self class allInstVarNames
		inject: self class greaseString hash
		into: [ :hash :varName |
			hash
				bitXor: 
					(self instVarNamed: varName) hash ]
]
