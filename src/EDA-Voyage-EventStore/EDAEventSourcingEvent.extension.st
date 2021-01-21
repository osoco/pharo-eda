Extension { #name : #EDAEventSourcingEvent }

{ #category : #'*EDA-Voyage-EventStore' }
EDAEventSourcingEvent class >> isVoyageRoot [
	^ true
]

{ #category : #'*EDA-Voyage-EventStore' }
EDAEventSourcingEvent class >> voyageRepository [
	^ voyageRepository
]

{ #category : #'*EDA-Voyage-EventStore' }
EDAEventSourcingEvent class >> voyageRepository: aVoyageRepository [
	voyageRepository := aVoyageRepository
]
