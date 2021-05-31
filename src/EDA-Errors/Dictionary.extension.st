Extension { #name : #Dictionary }

{ #category : #'*EDA-Errors' }
Dictionary class >> newFromObject: anObject [
	"Create a dictionary from the object allInstVarNames and its values."
	^ (anObject class allInstVarNames sorted
		collect: [ :varName | varName -> (anObject instVarNamed: varName) ]) asDictionary 
]
