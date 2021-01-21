Extension { #name : #EDAProjection }

{ #category : #'*EDA-Projections-Voyage-Repository' }
EDAProjection class >> isVoyageRoot [
	^ self subclassResponsibility
]

{ #category : #'*EDA-Projections-Voyage-Repository' }
EDAProjection class >> voyageCollectionName [
	^ self subclassResponsibility
]

{ #category : #'*EDA-Projections-Voyage-Repository' }
EDAProjection class >> voyageRepository [
	^ self repository repository
]
