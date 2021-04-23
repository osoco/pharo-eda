Trait {
	#name : #EDATCommandMaterializer,
	#category : #'EDA-Commands-Materializers'
}

{ #category : #accessing }
EDATCommandMaterializer >> builderFor: aString with: aCommandJson [
	| builder |
	builder := EDACommandBuilderRegistry uniqueInstance
		lookupBuilder: aString.
	builder
		ifNil: [ 
			builder := EDAPragmaBasedCommandBuilder newFor: aString with: aCommandJson ].
	^ builder
]
