Extension { #name : #EDAAggregateRoot }

{ #category : #'*EDA-Errors' }
EDAAggregateRoot >> asDictionary [
	^ Dictionary newFromObject: self
]

{ #category : #'*EDA-Errors' }
EDAAggregateRoot >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMap: self asDictionary
]
