Trait {
	#name : #EDATEventMaterializer,
	#category : #'EDA-Events-Materializers'
}

{ #category : #accessing }
EDATEventMaterializer >> builderFor: aString with: aMap [
	| builder |
	builder := EDAEventBuilderRegistry uniqueInstance
		lookupBuilder: aString.
	builder
		ifNil: [ builder := EDAPragmaBasedEventBuilder newFor: aString with: aMap ].
	^ builder
]
