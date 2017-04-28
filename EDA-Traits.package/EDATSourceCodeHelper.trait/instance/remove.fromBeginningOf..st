helper
remove: prefix fromBeginningOf: aString
	| result |
	result := (aString beginsWith: prefix) ifTrue: [ aString copyReplaceFrom: 1 to: prefix size with: '' ] ifFalse: [ aString ].
	^ result