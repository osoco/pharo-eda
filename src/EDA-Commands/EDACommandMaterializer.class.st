Class {
	#name : #EDACommandMaterializer,
	#superclass : #Object,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#category : #'EDA-Commands-Materializers'
}

{ #category : #parsing }
EDACommandMaterializer >> commandClassForName: aCommandName [
	^ self commandClassPrefix , (aCommandName copyWithRegex: '_' matchesReplacedWith: ' ') asLowercase asCamelCase
]

{ #category : #parsing }
EDACommandMaterializer >> commandClassPrefix [
	self subclassResponsibility
]

{ #category : #parsing }
EDACommandMaterializer >> materialize: aString [
	self subclassResponsibility
]
