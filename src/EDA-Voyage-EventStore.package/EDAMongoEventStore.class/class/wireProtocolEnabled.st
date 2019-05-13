accessing
wireProtocolEnabled
	wireProtocolEnabled ifNil: [ self wireProtocolEnabled: true ].
	^ wireProtocolEnabled