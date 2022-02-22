Extension { #name : #EDADeleteAggregateCommand }

{ #category : #'*EDA-Domain-Tests' }
EDADeleteAggregateCommand class >> attributesReceivedNotRequired [
	| attributesReceivedNotRequired |
	attributesReceivedNotRequired := super attributesReceivedNotRequired.
	attributesReceivedNotRequired addAll: (Set with: #delete).
	^ attributesReceivedNotRequired
]

{ #category : #'*EDA-Domain-Tests' }
EDADeleteAggregateCommand class >> testMessageClass [
	^ EDATestDeleteCommandMessage
]
