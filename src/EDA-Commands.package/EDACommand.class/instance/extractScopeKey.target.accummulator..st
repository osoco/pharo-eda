helpers
extractScopeKey: aDictionary target: aString accummulator: anOrderedCollection
	| result |
	result := OrderedCollection new.
	(aDictionary keys reject: [ :key | key = 'id' or: [ key = 'scope' ] ])
		do: [ :key | 
			key = aString
				ifTrue: [ anOrderedCollection
						ifNotEmpty: [ :c | result addAll: (self flatten: c) ].
					result add: ((aDictionary at: key) at: 'id') ]
				ifFalse: [ | accum |
					accum := OrderedCollection new.
					anOrderedCollection
						ifNotEmpty: [ :c | accum addAll: (self flatten: c) ].
					accum add: ((aDictionary at: key) at: 'id').
					result
						addAll:
							(self
								extractScopeKey: (aDictionary at: key)
								target: aString
								accummulator: accum) ] ].
	^ result