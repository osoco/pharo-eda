Extension { #name : #SequenceableCollection }

{ #category : #'*EDA-Domain-Tests' }
SequenceableCollection >> totallyMatches: anObject forTest: aTest [
	^ aTest collection: self totallyMatchesWith: anObject
]
