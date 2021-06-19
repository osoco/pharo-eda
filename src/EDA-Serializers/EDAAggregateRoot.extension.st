Extension { #name : #EDAAggregateRoot }

{ #category : #'*EDA-Serializers' }
EDAAggregateRoot >> asDictionary [
	^ Dictionary newFromObject: self
]

{ #category : #'*EDA-Serializers' }
EDAAggregateRoot >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMap: self asDictionary
]
