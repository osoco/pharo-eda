Class {
	#name : #EDAEventMaterializer,
	#superclass : #EDAMaterializer,
	#traits : 'EDATEventMaterializer',
	#classTraits : 'EDATEventMaterializer classTrait',
	#category : #'EDA-Events-Materializers'
}

{ #category : #initialization }
EDAEventMaterializer class >> parentBuilderClass [
	^ EDAEventBuilder
]
