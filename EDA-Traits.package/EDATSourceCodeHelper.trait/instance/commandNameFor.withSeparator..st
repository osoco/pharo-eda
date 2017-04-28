helper
commandNameFor: anEventName withSeparator: separator
	| result aux |
	result := nil.
	aux := anEventName allRegexMatches: '([^' , separator , ']*)'.
	aux size > 2
		ifTrue: [ | past rest present |
			rest := aux allButLast allButLast.
			past := aux allButLast last.
			present := self verbInPresentTense: past.
			result := ''.
			rest
				keysAndValuesDo: [ :i :noun |
					i < rest size
						ifTrue: [ result := result , separator ].
					result := result , noun ].
			result := present , separator , result ].
	^ result