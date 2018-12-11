helper
retrieveAggregateFromCommandType: json
	| result type aux |
	result := nil.
	aux := (json at: #meta) at: #type ifAbsent: [ nil ].
	aux 
		ifNotNil: [ :arg | 
			type := aux allRegexMatches: '([^_]*)'.
			type
				do: [ :word | 
					(self isAggregate: word)
						ifTrue: [ result := self toCamelCase: word asCamelCase ] ] ].
	^ result