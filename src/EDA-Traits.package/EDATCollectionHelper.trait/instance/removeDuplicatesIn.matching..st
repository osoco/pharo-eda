removing
removeDuplicatesIn: aCollection matching: aBlock
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