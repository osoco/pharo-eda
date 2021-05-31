Extension { #name : #EDACommand }

{ #category : #'*EDA-Errors' }
EDACommand >> asDictionary [
	^ Dictionary newFromObject: self
]

{ #category : #'*EDA-Errors' }
EDACommand >> neoJsonOn: neoJSONWriter [
	neoJSONWriter writeMap: self asDictionary
]
