Class {
	#name : #EDAProjectionVoyageRepository,
	#superclass : #EDAProjectionRepository,
	#instVars : [
		'repository'
	],
	#category : 'EDA-Projections-Voyage-Repository'
}

{ #category : #'class initialization' }
EDAProjectionVoyageRepository >> doInitialize [
	self repository: self initBackendRepository
]

{ #category : #persistence }
EDAProjectionVoyageRepository >> findAllOfTenant: aTenant [
	| criteria |
	criteria := Dictionary new.
	criteria at: 'tenant' put: aTenant.
	^ self selectMany: self where: criteria
]

{ #category : #persistence }
EDAProjectionVoyageRepository >> initBackendRepository [
	self subclassResponsibility 
]

{ #category : #'class initialization' }
EDAProjectionVoyageRepository >> initialize [
	super initialize.
	self doInitialize
]

{ #category : #persistence }
EDAProjectionVoyageRepository >> removeProjection: aProjectionClass [
	repository removeAll: aProjectionClass
]

{ #category : #accessing }
EDAProjectionVoyageRepository >> repository [
	^ repository
]

{ #category : #accessing }
EDAProjectionVoyageRepository >> repository: aRepository [
	repository := aRepository
]

{ #category : #persistence }
EDAProjectionVoyageRepository >> save: aProjection [
	aProjection save
]

{ #category : #persistence }
EDAProjectionVoyageRepository >> selectMany: aProjectionClass where: aDictionary [
	^ aProjectionClass selectMany: aDictionary.
]

{ #category : #persistence }
EDAProjectionVoyageRepository >> selectOfTenant: aTenant many: aProjectionClass where: aDictionary [
	| criteria |
	criteria := Dictionary newFrom: aDictionary.
	criteria at: 'tenant' put: aTenant.
	^ aProjectionClass selectMany: criteria.
]

{ #category : #persistence }
EDAProjectionVoyageRepository >> selectOfTenant: aTenant one: aProjectionClass where: aDictionary [
	| criteria |
	criteria := Dictionary newFrom: aDictionary.
	criteria at: 'tenant' put: aTenant.
	^ aProjectionClass selectOne: criteria
]

{ #category : #persistence }
EDAProjectionVoyageRepository >> selectOne: aProjectionClass where: aDictionary [
	^ aProjectionClass selectOne: aDictionary
]
