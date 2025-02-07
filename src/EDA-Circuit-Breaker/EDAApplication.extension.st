Extension { #name : #EDAApplication }

{ #category : #'*EDA-Circuit-Breaker' }
EDAApplication class >> eventStoreCheckBlock [
	^ [ :monitoredEventStore | 
		| check |
		check := true.
		[ EDAEventStore healthCheckBlock value: monitoredEventStore ]
			on: Error
			do: [ :error | check := false ].
		check ]
]

{ #category : #'*EDA-Circuit-Breaker' }
EDAApplication class >> startCommandConsumerBlock [
	^ [ commandConsumer start ]
]

{ #category : #'*EDA-Circuit-Breaker' }
EDAApplication class >> stopCommandConsumerBlock [
	^ [ commandConsumer stop ]
]
