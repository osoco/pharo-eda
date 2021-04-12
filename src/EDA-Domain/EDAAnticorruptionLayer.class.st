Class {
	#name : #EDAAnticorruptionLayer,
	#superclass : #Object,
	#traits : 'EDATLogging',
	#classTraits : 'EDATLogging classTrait',
	#category : #'EDA-Domain-Services'
}

{ #category : #testing }
EDAAnticorruptionLayer class >> isAggregateRoot [
	^ false
]
