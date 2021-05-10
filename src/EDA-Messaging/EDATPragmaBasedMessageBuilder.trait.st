Trait {
	#name : #EDATPragmaBasedMessageBuilder,
	#traits : 'EDATPragmaHelper',
	#classTraits : 'EDATPragmaHelper classTrait',
	#category : #'EDA-Messaging-Builders'
}

{ #category : #meta }
EDATPragmaBasedMessageBuilder classSide >> pragmaSymbol [
	self subclassResponsibility 
]

{ #category : #meta }
EDATPragmaBasedMessageBuilder >> pragmaSymbol [
	^ self class pragmaSymbol
]
