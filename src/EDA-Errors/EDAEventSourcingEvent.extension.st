Extension { #name : #EDAEventSourcingEvent }

{ #category : #'*EDA-Errors' }
EDAEventSourcingEvent >> asDictionary [
	^ Dictionary newFromObject: self
]

{ #category : #'*EDA-Errors' }
EDAEventSourcingEvent >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMap: self asDictionary
]
