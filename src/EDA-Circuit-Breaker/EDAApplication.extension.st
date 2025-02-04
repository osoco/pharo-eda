Extension { #name : #EDAApplication }

{ #category : #'*EDA-Circuit-Breaker' }
EDAApplication class >> eventStoreCheckBlock [
	self flag: #TODO.	"Obtain from settings"
	^ [ :monitoredEventStore | 
		| check |
		check := true.
		[ monitoredEventStore
			findEventsOfAggregate: 'nonExistent'
			whereId: 'nonExistent' ] on: Error do: [ check := false ].
		check ]
]

{ #category : #'*EDA-Circuit-Breaker' }
EDAApplication class >> eventStoreCheckingPeriod [
	self flag: #TODO. "Obtain from settings"
	^ 10 seconds 
]

{ #category : #'*EDA-Circuit-Breaker' }
EDAApplication class >> eventStoreMaxConsecutiveCheckFailures [
	self flag: #TODO.	"Obtain from settings"
	^ 5
]

{ #category : #'*EDA-Circuit-Breaker' }
EDAApplication class >> eventStoreMinConsecutiveCheckSuccesses [
	self flag: #TODO.	"Obtain from settings"
	^ 5
]

{ #category : #'*EDA-Circuit-Breaker' }
EDAApplication class >> startCommandConsumerBlock [
	self flag: #TODO.	"Obtain from settings"
	^ [ commandConsumer start ]
]

{ #category : #'*EDA-Circuit-Breaker' }
EDAApplication class >> stopCommandConsumerBlock [
	self flag: #TODO.	"Obtain from settings"
	^ [ commandConsumer stop ]
]
