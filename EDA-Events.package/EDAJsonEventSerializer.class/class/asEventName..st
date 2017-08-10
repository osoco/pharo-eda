converting
asEventName: event
	| words |
	words :=
		event delete ifTrue: [
			| aggregateRootName |
			aggregateRootName := (EDAMessageSerializer nameWithoutPrefixForMessageClass: event aggregateRootClass) asUppercase.
			OrderedCollection with: aggregateRootName with: 'DELETED'
		] ifFalse: [
			(EDAMessageSerializer nameWithoutPrefixForMessageClass: event class)
				regex: '[A-Z][a-z]+' matchesCollect: [ :word | word greaseString asUppercase ].
		].
	^ String streamContents: [ :stream | words asStringOn: stream delimiter: '_' ]
