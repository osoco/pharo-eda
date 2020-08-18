helper
readEventExampleFile
	| result stream |
	stream := self eventFile exists
		ifTrue: [ self eventFile readStream ]
		ifFalse: [ nil ].
	result := stream ifNil: [ nil ] ifNotNil: [ :s | s contents ].
	stream ifNotNil: [ :s | s close ].
	^ result