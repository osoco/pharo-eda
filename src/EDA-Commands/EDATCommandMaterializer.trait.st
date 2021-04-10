Trait {
	#name : #EDATCommandMaterializer,
	#category : #'EDA-Commands-Materializers'
}

{ #category : #accessing }
EDATCommandMaterializer >> builderFor: aString with: map [
	| builder |
	builder := EDACommandBuilderRegistry uniqueInstance
		lookupBuilder: aString.
	builder
		ifNil: [ self
				logErrorMessage: 'Received unsupported ' , aString greaseString
				andThrow: EDAInvalidCommandMessage ].
	^ builder
]
