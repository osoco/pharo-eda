Extension { #name : #EDAEventSourcingEvent }

{ #category : #'*EDA-Messaging' }
EDAEventSourcingEvent >> routingKey [
	^ EDASourceCodeHelperStub new
		camelCaseToDotSeparated: (EDAMessageSerializer nameWithoutPrefixForMessageClass: self class)
]
