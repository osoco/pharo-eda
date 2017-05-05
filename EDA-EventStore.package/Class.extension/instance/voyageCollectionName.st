*EDA-EventStore
voyageCollectionName
	"This method can be overridden with a more meaningful collection name"

	^ ((self persistentClass greaseString first: 3) allSatisfy: #isUppercase)
		ifTrue: [ self persistentClass greaseString allButFirst: 2 ]
		ifFalse: [ self persistentClass greaseString ]