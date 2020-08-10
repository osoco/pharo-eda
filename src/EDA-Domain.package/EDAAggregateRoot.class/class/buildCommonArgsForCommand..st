helpers
buildCommonArgsForCommand: aCommand
	| result |
	result := Dictionary new.
	result at: 'version' put: aCommand version.
	result at: 'aggregateRootVersion' put: aCommand aggregateRootVersion.
		result at: 'aggregateRootClass' put: self class.
	aCommand scopeKey ifNotNil: [ :key | result at: 'scopeKey' put: key ].
	aCommand scopeContext
		ifNotNil: [ :ctx | result at: 'scopeContext' put: ctx ].
	^ result