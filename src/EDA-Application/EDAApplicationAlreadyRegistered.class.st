Class {
	#name : #EDAApplicationAlreadyRegistered,
	#superclass : #Error,
	#category : #'EDA-Application'
}

{ #category : #'instance creation' }
EDAApplicationAlreadyRegistered class >> on: anEDAApplication [
	^ self new
		edaApplication: anEDAApplication;
		yourself
]
