Trait {
	#name : #EDATEqualsHelper,
	#category : #'EDA-Traits'
}

{ #category : #comparing }
EDATEqualsHelper >> = anInstance [
	^ self class = anInstance class
		and: [ self class allInstVarNames
				allSatisfy: [ :varName | (varName value: self) = (varName value: anInstance) ] ]
]
