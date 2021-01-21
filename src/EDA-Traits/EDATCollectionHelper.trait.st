Trait {
	#name : #EDATCollectionHelper,
	#category : 'EDA-Traits'
}

{ #category : #removing }
EDATCollectionHelper >> csvToCollection: aString [
	| result |
	result := OrderedCollection new.
	aString splitOn: ',' do: [ :s | result add: s trim ].
	^ result
]

{ #category : #removing }
EDATCollectionHelper >> flatten: aCollection [
	| result |
	result := OrderedCollection new.
	aCollection
		do: [ :item |
			((item isKindOf: OrderedCollection) or: [ item isKindOf: Array ] )
				ifTrue: [ result addAll: (self flatten: item) ]
				ifFalse: [ result add: item ] ].
	^ result
]

{ #category : #removing }
EDATCollectionHelper >> removeDuplicatesIn: aCollection matching: aBlock [
	| result duplicates |
	duplicates := aCollection select: [ :it | (aCollection count: [ :el | aBlock value: it value: el ]) > 1 ].
	result := (aCollection
		collect: [ :it | 
			(duplicates includes: it)
				ifTrue: [ (duplicates select: [ :el | aBlock value: it value: el ]) first = it
						ifTrue: [ it ]
						ifFalse: [ nil ] ]
				ifFalse: [ it ] ]) select: [ :it | it isNotNil ].
		
	^ result
]
