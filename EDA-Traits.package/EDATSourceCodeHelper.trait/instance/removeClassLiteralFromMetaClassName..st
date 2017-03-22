helper
removeClassLiteralFromMetaClassName: aString
	^ ' class$' asRegexIgnoringCase copy: aString replacingMatchesWith: ''