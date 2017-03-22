helper
retrieveEventName
	| result aux |
	aux := self commandName allRegexMatches: '([^_]*)'.
	aux size > 2
		ifTrue: [ | verb rest past |
			verb := aux at: 1.
			rest := aux allButFirst.
			past := self verbInPastTense: verb.
			result := ''.
			rest
				doWithIndex: [ :noun :i |
					i > 1
						ifTrue: [ result := result , '_' ].
					result := result , noun ].
			result := result  , past ]
		ifFalse: [ result := 'unknown' ].	"the last one is empty"
	^ result