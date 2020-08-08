removing
flatten: aCollection
	| result |
	result := OrderedCollection new.
	aCollection
		do: [ :item | 
			((item isKindOf: OrderedCollection) or: [ item isKindOf: Array ] )
				ifTrue: [ result addAll: (self flatten: item) ]
				ifFalse: [ result add: item ] ].
	^ result