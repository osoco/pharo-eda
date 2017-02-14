parsing
serialize: anEvent
	| writerBlock |
	(anEvent isKindOf: Error) 
		ifTrue: [ writerBlock := self errorWriter ]
		ifFalse: [ writerBlock := self writer ].
	^ writerBlock value: anEvent