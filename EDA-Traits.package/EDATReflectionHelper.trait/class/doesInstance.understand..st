as yet unclassified
doesInstance: anInstance understand: aString
	| method |
	method := anInstance methodDict at: aString ifAbsent: [ nil ].
	^ method isNotNil