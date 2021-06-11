Class {
	#name : #EDATestAggregateRoot,
	#superclass : #EDAAggregateRoot,
	#instVars : [
		'sut',
		'counters'
	],
	#category : #'EDA-TestSupport'
}

{ #category : #'instance creation' }
EDATestAggregateRoot class >> with: aContest [
	^ self new sut: aContest;
	yourself 
]

{ #category : #accessing }
EDATestAggregateRoot >> counters [
	^ counters ifNil: [ counters := Dictionary new ]
]

{ #category : #accessing }
EDATestAggregateRoot >> counters: anObject [
	counters := anObject
]

{ #category : #'reflective operations' }
EDATestAggregateRoot >> doesNotUnderstand: aMessage [
	| count |
	count := self counters at: aMessage ifAbsent: [ 0 ].
	self counters at: aMessage selector put: count + 1.
	^ aMessage sendTo: self sut
]

{ #category : #testing }
EDATestAggregateRoot >> hasApplied: aSelector [
	^ counters at: aSelector ifPresent: [ :v | v > 0 ] ifAbsent: [ false ] 
]

{ #category : #'class membership' }
EDATestAggregateRoot >> respondsTo: aSelector [
	^ self sut respondsTo: aSelector
]

{ #category : #accessing }
EDATestAggregateRoot >> sut [
	^ sut
]

{ #category : #accessing }
EDATestAggregateRoot >> sut: anObject [
	sut := anObject
]
