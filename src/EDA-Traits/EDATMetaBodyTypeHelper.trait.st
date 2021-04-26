Trait {
	#name : #EDATMetaBodyTypeHelper,
	#category : #'EDA-Traits'
}

{ #category : #testing }
EDATMetaBodyTypeHelper >> retrieveType: aDictionary [
	| meta |
	meta := aDictionary at: #meta ifAbsent: [ nil ].
	^ meta ifNotNil: [ meta at: #type ifAbsent: [ nil ] ]
]
