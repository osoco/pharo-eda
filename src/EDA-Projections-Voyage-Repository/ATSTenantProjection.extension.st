Extension { #name : #ATSTenantProjection }

{ #category : #'*EDA-Projections-Voyage-Repository' }
ATSTenantProjection class >> isVoyageRoot [
	^ true
]

{ #category : #'*EDA-Projections-Voyage-Repository' }
ATSTenantProjection class >> voyageCollectionName [
	^ 'TenantProjection'
]
