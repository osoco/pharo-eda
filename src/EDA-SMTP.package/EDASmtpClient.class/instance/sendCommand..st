accessing
sendCommand: aString
	| result |
	result := super sendCommand: aString.
	(aString = 'QUIT') ifTrue: [ self flushPendingLog ].
	^ result