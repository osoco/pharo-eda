Class {
	#name : #EDACommandMaterializer,
	#superclass : #EDAMaterializer,
	#category : #'EDA-Commands-Materializers'
}

{ #category : #meta }
EDACommandMaterializer class >> builderTrait [
	^ EDATCommandBuilder
]
