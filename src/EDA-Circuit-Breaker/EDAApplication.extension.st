Extension { #name : #EDAApplication }

{ #category : #'*EDA-Circuit-Breaker' }
EDAApplication class >> eventStoreCheckBlock [
	^ [ :monitoredEventStore | 
		| check |
		check := true.
		[ monitoredEventStore
			findEventsOfAggregate: 'nonExistent'
			whereId: 'nonExistent' ] on: Error do: [ check := false ].
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
