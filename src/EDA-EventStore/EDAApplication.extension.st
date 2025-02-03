Extension { #name : #EDAApplication }

{ #category : #'*EDA-EventStore' }
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

{ #category : #'*EDA-EventStore' }
EDAApplication class >> eventStoreCheckingPeriod [
	self flag: #TODO. "Obtain from settings"
	^ 1 minute
]

{ #category : #'*EDA-EventStore' }
EDAApplication class >> eventStoreMaxConsecutiveCheckFailures [
	self flag: #TODO.	"Obtain from settings"
	^ 5
]

{ #category : #'*EDA-EventStore' }
EDAApplication class >> eventStoreMinConsecutiveCheckSuccesses [
	self flag: #TODO.	"Obtain from settings"
	^ 5
]

{ #category : #'*EDA-EventStore' }
EDAApplication class >> startCommandConsumerBlock [
	self flag: #TODO.	"Obtain from settings"
	^ [ commandConsumer start ]
]

{ #category : #'*EDA-EventStore' }
EDAApplication class >> stopCommandConsumerBlock [
	self flag: #TODO.	"Obtain from settings"
	^ [ commandConsumer stop ]
]
