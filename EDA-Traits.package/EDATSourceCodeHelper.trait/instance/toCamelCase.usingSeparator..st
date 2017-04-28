helper
toCamelCase: aString usingSeparator: separator
	| aux result |
	aux := separator asRegexIgnoringCase copy: aString replacingMatchesWith: ' '.
	result := aux = aux asUppercase
		ifTrue: [ aux asLowercase asCamelCase ]
		ifFalse: [ aux asCamelCase  ].
	^ result