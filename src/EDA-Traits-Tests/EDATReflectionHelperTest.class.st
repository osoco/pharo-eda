Class {
	#name : #EDATReflectionHelperTest,
	#superclass : #TestCase,
	#traits : 'EDATReflectionHelper',
	#classTraits : 'EDATReflectionHelper classTrait',
	#category : 'EDA-Traits-Tests'
}

{ #category : #tests }
EDATReflectionHelperTest >> testDoesInstanceUnderstand [
	self assert: (self doesInstance: self understand: #doesInstance:understand:)
]
