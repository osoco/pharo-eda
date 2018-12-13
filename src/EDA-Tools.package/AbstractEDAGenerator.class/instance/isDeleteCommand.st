accessing
isDeleteCommand
	| delete meta |
	meta := commandJson at: #meta ifAbsent: [ nil ].
	delete := meta ifNil: [ nil ] ifNotNil: [ :m | m at: #delete ifAbsent: [ nil ] ].
	^ delete isNotNil
	