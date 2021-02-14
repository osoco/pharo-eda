Trait {
	#name : #EDATPortResolver,
	#category : #'EDA-Settings-Ports'
}

{ #category : #logic }
EDATPortResolver >> availableAdapters: aPort [
	^ aPort traitUsers select: [ :cls | cls accepts: self ]
]
