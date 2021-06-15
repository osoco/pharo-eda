Trait {
	#name : #EDATEventBuilder,
	#category : #'EDA-Events-Builders'
}

{ #category : #meta }
EDATEventBuilder classSide >> errorClass [
	^ EDAInvalidEventMessage
]

{ #category : #meta }
EDATEventBuilder classSide >> messageClass [
	^ EDAEvent
]

{ #category : #meta }
EDATEventBuilder >> errorClass [
	^ self class errorClass
]

{ #category : #meta }
EDATEventBuilder >> messageClass [
	^ self class messageClass
]
