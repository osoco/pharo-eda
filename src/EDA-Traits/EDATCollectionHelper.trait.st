Trait {
	#name : #EDATCollectionHelper,
	#category : #'EDA-Traits'
}

{ #category : #helper }
EDATCollectionHelper classSide >> concatenateCollection: aCollection with: aSeparator [
	| txt |
	txt := ''.
	aCollection
		keysAndValuesDo: [ :i :item | 
			i > 1
				ifTrue: [ txt := txt , aSeparator ].
			txt := txt , item ].
	^ txt
]

{ #category : #helper }
EDATCollectionHelper classSide >> csvToCollection: aString [
	| result |
	result := OrderedCollection new.
	aString splitOn: ',' do: [ :s | result add: s trim ].
	^ result
]

{ #category : #helper }
EDATCollectionHelper classSide >> flatten: aCollection [
	| result |
	result := OrderedCollection new.
	aCollection
		do: [ :item | 
			(item isCollection or: [ item isArray ])
				ifTrue: [ result addAll: (self flatten: item) ]
				ifFalse: [ result add: item ] ].
	^ result
]

{ #category : #helper }
EDATCollectionHelper classSide >> removeDuplicatesIn: aCollection matching: aBlock [
	| result duplicates |
	duplicates := aCollection
		select:
			[ :it | (aCollection count: [ :el | aBlock value: it value: el ]) > 1 ].
	result := (aCollection
		collect: [ :it | 
			(duplicates includes: it)
				ifTrue: [ (duplicates select: [ :el | aBlock value: it value: el ]) first = it
						ifTrue: [ it ]
						ifFalse: [ nil ] ]
				ifFalse: [ it ] ]) select: [ :it | it isNotNil ].
	^ result
]

{ #category : #helper }
EDATCollectionHelper >> concatenateCollection: aCollection with: aSeparator [
	^ self class concatenateCollection: aCollection with: aSeparator

]

{ #category : #helper }
EDATCollectionHelper >> csvToCollection: aString [
	^ self class csvToCollection: aString
]

{ #category : #helper }
EDATCollectionHelper >> flatten: aCollection [
	^ self class flatten: aCollection
]

{ #category : #helper }
EDATCollectionHelper >> removeDuplicatesIn: aCollection matching: aBlock [
	^ self class removeDuplicatesIn: aCollection matching: aBlock
]
