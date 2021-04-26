Class {
	#name : #EDAJsonCommandMaterializer,
	#superclass : #EDAJsonMaterializer,
	#traits : 'EDATCommandMaterializer',
	#classTraits : 'EDATCommandMaterializer classTrait',
	#category : #'EDA-Commands-Materializers'
}

{ #category : #meta }
EDAJsonCommandMaterializer class >> parentBuilderClass [
	^ EDAMetaBodyCommandBuilder
]
