Class {
	#name : #EDAMMClassDefinitionWrapper,
	#superclass : #Object,
	#instVars : [
		'wrapped',
		'category'
	],
	#category : #'EDA-Multimodule-Migration'
}

{ #category : #'instance creation' }
EDAMMClassDefinitionWrapper class >> for: aMCClassDefinition andCategory: aString [
	^ self new wrapped: aMCClassDefinition; category: aString; yourself
]

{ #category : #accessing }
EDAMMClassDefinitionWrapper >> category [
	^ category
]

{ #category : #accessing }
EDAMMClassDefinitionWrapper >> category: anObject [
	category := anObject
]

{ #category : #'class membership' }
EDAMMClassDefinitionWrapper >> class [
	^ self wrapped class
]

{ #category : #introspection }
EDAMMClassDefinitionWrapper >> className [
	^ self wrapped className
]

{ #category : #'reflective operations' }
EDAMMClassDefinitionWrapper >> doesNotUnderstand: aMessage [
	^ aMessage hasArguments ifTrue: [ 
	self wrapped perform: aMessage selector with: aMessage arguments ] ifFalse: [ self wrapped perform: aMessage selector ]
]

{ #category : #accessing }
EDAMMClassDefinitionWrapper >> wrapped [
	^ wrapped
]

{ #category : #accessing }
EDAMMClassDefinitionWrapper >> wrapped: anObject [
	wrapped := anObject
]
