as yet unclassified
routingKey: anEvent
	| applicationId |
	^ (anEvent isKindOf: EDAEventSourcingEvent)
		ifTrue: [ 
			applicationId := (anEvent respondsTo: 'applicationId' asSymbol)
				ifTrue: [ anEvent applicationId ]
				ifFalse: [ anEvent id ].
			applicationId , '.' , (EDAMessageSerializer nameWithoutPrefixForMessageClass: anEvent class) ]