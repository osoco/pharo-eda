Class {
	#name : #EDAVOProjectionMongoRepository,
	#superclass : #VOMongoRepository,
	#category : 'EDA-Projections-Voyage-Repository'
}

{ #category : #persistence }
EDAVOProjectionMongoRepository >> collectionNameFor: aClass [
	^ aClass voyageCollectionName
]

{ #category : #persistence }
EDAVOProjectionMongoRepository >> findAllProjections: aClass ofTenant: aTenant [
	| criteria |
	criteria := Dictionary new.
	criteria at: 'tenant' put: aTenant.
	^ self
		selectMany: aClass
		where: criteria
		sortBy:
			(OrderedCollection
				with: #timestamp -> VOOrder ascending
				with: #_id -> VOOrder ascending) asDictionary
]

{ #category : #persistence }
EDAVOProjectionMongoRepository >> selectMany: aClass where: aBlock sortBy: sortBlock [
	^ self selectManyOperation
		queryClass: aClass;
		where: aBlock;
		sortBlock: sortBlock;
		execute

]
