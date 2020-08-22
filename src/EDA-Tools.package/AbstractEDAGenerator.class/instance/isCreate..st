helper
isCreate: json
	| type meta |
	meta := json at: #meta ifAbsent: [ nil ].
	type := meta
		ifNil: [ '' ]
		ifNotNil: [ :m | m at: #type ifAbsent: [ nil ] ].
	^ '^CREATE_.+' asRegexIgnoringCase matches: type