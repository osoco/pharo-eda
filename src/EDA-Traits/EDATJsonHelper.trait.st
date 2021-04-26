Trait {
	#name : #EDATJsonHelper,
	#category : #'EDA-Traits'
}

{ #category : #parsing }
EDATJsonHelper >> parseJson: aString [ 
	^ NeoJSONReader fromString: aString
]
