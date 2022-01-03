Class {
	#name : #EDAMismatchError,
	#superclass : #Error,
	#instVars : [
		'diff'
	],
	#category : #'EDA-Domain-Tests'
}

{ #category : #exceptioninstantiator }
EDAMismatchError class >> signal: message withDiff: aDiff [
	"Signal the occurrence of an exceptional condition with a specified textual description and diff"

	^ self new diff: aDiff; signal: message
]

{ #category : #accessing }
EDAMismatchError >> diff [
	^ diff
]

{ #category : #accessing }
EDAMismatchError >> diff: anObject [
	diff := anObject
]
