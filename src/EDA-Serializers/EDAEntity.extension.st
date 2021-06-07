Extension { #name : #EDAEntity }

{ #category : #'*EDA-Serializers' }
EDAEntity >> asDictionary [
	^ Dictionary newFromObject: self
]

{ #category : #'*EDA-Serializers' }
EDAEntity >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMap: self asDictionary
]
