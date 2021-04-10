Class {
	#name : #EDAMaterializer,
	#superclass : #Object,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#category : #'EDA-Messaging-Materializers'
}

{ #category : #accessing }
EDAMaterializer >> builderFor: aString with: aMap [
	self subclassResponsibility
]

{ #category : #private }
EDAMaterializer >> materialize: aString [
	self subclassResponsibility
]
