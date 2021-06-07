Extension { #name : #EDAEventSourcingEvent }

{ #category : #'*EDA-Serializers' }
EDAEventSourcingEvent >> asDictionary [
	^ Dictionary newFromObject: self
]

{ #category : #'*EDA-Serializers' }
EDAEventSourcingEvent >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMap: self asDictionary
]
