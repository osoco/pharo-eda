Trait {
	#name : #EDATCommandMaterializer,
	#category : #'EDA-Commands-Materializers'
}

{ #category : #accessing }
EDATCommandMaterializer >> builderFor: aString with: aCommandJson [
	| builder params |
	builder := EDACommandBuilderRegistry uniqueInstance
		lookupBuilder: aString.
	builder
		ifNil: [ 
			params := self transfomCommandJsonToParams: aCommandJson.
			builder := EDAPragmaBasedCommandBuilder newFor: aString with: params ].
	^ builder
]

{ #category : #accessing }
EDATCommandMaterializer >> transfomCommandJsonToParams: aCommandJson [
	| meta body params |
	meta := aCommandJson at: #meta ifAbsent: [ nil ].
	body := aCommandJson at: #body ifAbsent: [ nil ].	
	(meta isNil or: [ body isNil ])
		ifTrue: [ self
				logErrorMessage: 'Invalid JSON (meta or body missing)'
				andThrow: EDAInvalidCommandMessage ]
		ifFalse: [
			[ 
				| metaKeys bodyKeys metaValues bodyValues keys values |
				(meta at: #timestamp put: (DateAndTime fromString: (meta at: #timestamp))).
				metaKeys := meta keys.
				metaValues := meta values.
				metaKeys replace: [ :metaKey | 
					| key |
					key := metaKey.
					metaKey = #id
						ifTrue: [ key := #commandId ]
						ifFalse: [ 
							metaKey = #timestamp
							ifTrue: [ key := #originalTimestamp ]
						].
					key
				].
				bodyKeys := body keys.
				bodyValues := body values.
				bodyKeys replace: [ :bodyKey |
					| key |
					key := bodyKey.
					bodyKey = #id
						ifTrue: [ key := #aggregateRootId ]
						ifFalse: [
							bodyKey = #version
								ifTrue: [ key := #aggregateRootVersion ]
						].
						key 
				].
				keys := OrderedCollection newFrom: metaKeys.
				keys addAll: bodyKeys.
				values := OrderedCollection newFrom: metaValues.
				values addAll: bodyValues.
				params := Dictionary newFromKeys: keys andValues: values.
			
				^ params
			]
			on: Exception
			do: [ :ex |
			self
					logErrorMessage:
						((WriteStream on: String new)
							nextPutAll: 'Command rejected: ';
							nextPutAll: ex greaseString;
							close;
							contents)
					andThrow: EDAInvalidCommandMessage ]
		]
]
