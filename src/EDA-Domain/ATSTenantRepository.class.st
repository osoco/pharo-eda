Class {
	#name : #ATSTenantRepository,
	#superclass : #Object,
	#instVars : [
		'eventStore'
	],
	#category : 'EDA-Domain-Repository'
}

{ #category : #accessing }
ATSTenantRepository >> eventStore [
	^ eventStore
]

{ #category : #accessing }
ATSTenantRepository >> eventStore: anEventStore [
	eventStore := anEventStore
]

{ #category : #'as yet unclassified' }
ATSTenantRepository >> findAllTenants [
	^ OrderedCollection new
]
