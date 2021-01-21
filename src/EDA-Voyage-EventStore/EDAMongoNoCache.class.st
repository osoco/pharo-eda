Class {
	#name : #EDAMongoNoCache,
	#superclass : #VOCache,
	#category : 'EDA-Voyage-EventStore'
}

{ #category : #accessing }
EDAMongoNoCache >> at: anOID put: anObject [
	"Do nothing"
]

{ #category : #accessing }
EDAMongoNoCache >> keyAtValue: anObject [
	"Do nothing"
	^ nil

]

{ #category : #accessing }
EDAMongoNoCache >> keyAtValue: anObject ifAbsent: aBlock [
	"Do nothing"

	^ nil
]
