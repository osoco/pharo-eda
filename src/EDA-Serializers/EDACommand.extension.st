Extension { #name : #EDACommand }

{ #category : #'*EDA-Serializers' }
EDACommand >> asDictionary [
	^ Dictionary newFromObject: self
]

{ #category : #'*EDA-Serializers' }
EDACommand >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMap: self asDictionary
]
