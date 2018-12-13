comparing
deepEqualsArrayOrCollection: anArrayOrCollection with: anotherArrayOrCollection
	^ (self sizeIsEqualExcludingNils: anArrayOrCollection with: anotherArrayOrCollection)
		and: [ | first second aux |
			first := anArrayOrCollection reject: [ :v | v isNil ].
			second := anArrayOrCollection reject: [ :v | v isNil ].
			aux := OrderedCollection new.
			first	keysAndValuesDo: [ :i :v | 
				| w |
				w := second at: i.
				aux add:
					((self areArrayOrCollectionBoth: v and: w)
						ifTrue: [ self deepEqualsArrayOrCollection: v with: w ]
						ifFalse: [ self deepEquals: v with: w ])
			].
			(aux reject: [ :x | x ]) isEmpty
		]