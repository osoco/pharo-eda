Trait {
	#name : #EDAPortResolver,
	#category : #'EDA-Settings-Ports'
}

{ #category : #logic }
EDAPortResolver >> availableAdapters: aPort [
	^ aPort traitUsers select: [ :cls | cls accepts: self ]
]
