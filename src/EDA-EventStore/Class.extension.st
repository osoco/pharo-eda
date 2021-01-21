Extension { #name : #Class }

{ #category : #'*EDA-EventStore' }
Class >> voyageCollectionName [
	"This method can be overridden with a more meaningful collection name"

	| collectionName index firstLowercaseIndex |
	collectionName := self persistentClass greaseString.
	index := 1.
	firstLowercaseIndex := 0.
	[ index <= collectionName size and: firstLowercaseIndex = 0 ]
		whileTrue: [ (collectionName at: index) isLowercase
				ifTrue: [ firstLowercaseIndex := index ].
			index := index + 1 ].
	^ firstLowercaseIndex > 1
		ifTrue: [ collectionName allButFirst: (firstLowercaseIndex - 2) ]
		ifFalse: [ collectionName ]
]
