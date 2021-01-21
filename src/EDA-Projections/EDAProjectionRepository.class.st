Class {
	#name : #EDAProjectionRepository,
	#superclass : #Object,
	#category : 'EDA-Projections-Repository'
}

{ #category : #persistence }
EDAProjectionRepository >> findAllOfTenant: aTenant [
	self subclassResponsibility
]

{ #category : #persistence }
EDAProjectionRepository >> removeProjection: aProjectionClass [
	self subclassResponsibility
]

{ #category : #persistence }
EDAProjectionRepository >> save: aProjection [
	self subclassResponsibility
]
