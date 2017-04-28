helper
retrieveEventName
	| result aux |
	result := nil.
	aux := self eventName allRegexMatches: '([^_]*)'.
	aux size > 2
		ifTrue: [ | verb rest past |
			verb := aux at: 1.
			rest := aux allButFirst.
			past := self verbInPastTense: verb.
			result := ''.
			rest
				keysAndValuesDo: [ :i :noun | 
					i > 1
						ifTrue: [ result := result , '_' ].
					result := result , noun ].
			result := result , past ].
	^ result