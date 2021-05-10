Trait {
	#name : #EDATTypeAttributeBuilder,
	#category : #'EDA-Messaging-Builders'
}

{ #category : #testing }
EDATTypeAttributeBuilder >> retrieveType: aDictionary [
	^ aDictionary at: #type ifAbsent: [ nil ]
]
