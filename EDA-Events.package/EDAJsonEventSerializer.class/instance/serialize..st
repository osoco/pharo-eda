parsing
serialize: anEvent
	| writerBlock |
	writerBlock := (anEvent isKindOf: Error)
		ifTrue: [ self errorWriter ]
		ifFalse: [ self writer ].
	^ writerBlock value: anEvent