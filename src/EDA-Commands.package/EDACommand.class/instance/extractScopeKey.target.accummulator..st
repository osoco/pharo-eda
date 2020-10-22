helpers
extractScopeKey: aDictionary target: aString accummulator: anOrderedCollection
	| result |
	result := OrderedCollection new.
	(aDictionary isNotNil and: [ aString isNotNil ])
		ifTrue: [ (aDictionary keys
				reject: [ :key | (OrderedCollection with: 'id' with: 'scope') includes: key ])
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
										accummulator: accum) ] ] ].
	^ result