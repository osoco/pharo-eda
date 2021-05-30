Class {
	#name : #EDAMessageSerializer,
	#superclass : #Object,
	#traits : 'EDACPrintOnHelper',
	#classTraits : 'EDACPrintOnHelper classTrait',
	#category : #'EDA-Messaging-Serializers'
}

{ #category : #parsing }
EDAMessageSerializer class >> eventClassPrefix: aClass [
	^ (aClass asString regex: '^([A-Z]+)' matchesCollect: [ :each | each asString ]) first allButLast
]

{ #category : #parsing }
EDAMessageSerializer class >> nameForMessageClass: aMessageClass [
	^ ((self nameWithoutPrefixForMessageClass: aMessageClass)
		copyWithRegex: '([A-Z]+)([a-z]+)'
		matchesTranslatedUsing: [ :each | each asString , '_' ]) allButLast asUppercase
]

{ #category : #parsing }
EDAMessageSerializer class >> nameWithoutPrefixForMessageClass: aMessageClass [
	^ aMessageClass asString allButFirst: (self eventClassPrefix: aMessageClass) size
]

{ #category : #parsing }
EDAMessageSerializer >> serialize: anEvent [
	self subclassResponsibility
]
