Extension { #name : #EDADeleteAggregateCommand }

{ #category : #'*EDA-Domain-Tests' }
EDADeleteAggregateCommand class >> templateAttributesNotRequired [
	| attributesReceivedNotRequired |
	attributesReceivedNotRequired := super templateAttributesNotRequired.
	attributesReceivedNotRequired addAll: (Set with: #delete).
	^ attributesReceivedNotRequired
]

{ #category : #'*EDA-Domain-Tests' }
EDADeleteAggregateCommand class >> testMessageClass [
	^ EDATestDeleteCommandMessage
]
