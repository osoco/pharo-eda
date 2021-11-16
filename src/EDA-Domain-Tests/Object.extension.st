Extension { #name : #Object }

{ #category : #'*EDA-Domain-Tests' }
Object >> totallyMatches: anObject forTest: aTest [
	^ aTest object: self totallyMatchesWith: anObject
]
