helpers
doesInstance: anInstance understand: aString
	| method |
	method := anInstance class methodDict at: aString ifAbsent: [ nil ].
	^ method isNotNil