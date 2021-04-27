Trait {
	#name : #EDATCommandMaterializer,
	#category : #'EDA-Commands-Materializers'
}

{ #category : #accessing }
EDATCommandMaterializer >> builderFor: aString with: aCommandJson [
	^ EDAPragmaBasedCommandBuilder
				newFor: aString
				with: aCommandJson
]
