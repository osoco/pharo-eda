Extension { #name : #Dictionary }

{ #category : #'*EDA-Domain-Tests' }
Dictionary >> totallyMatches: anObject forTest: aTest [
	^ aTest dictionary: self totallyMatchesWith: anObject
]
