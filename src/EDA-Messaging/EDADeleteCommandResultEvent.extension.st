Extension { #name : #EDADeleteCommandResultEvent }

{ #category : #'*EDA-Messaging' }
EDADeleteCommandResultEvent >> routingKey [
	^ (EDAMessageSerializer nameWithoutPrefixForMessageClass: self aggregateRootClass) asLowercase , '.deleted'
]
