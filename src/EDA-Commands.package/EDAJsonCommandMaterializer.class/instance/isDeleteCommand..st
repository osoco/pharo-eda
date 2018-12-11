delete logic
isDeleteCommand: aDict
    "Checks whether is a delete command"
	| meta |
	meta := aDict at: #meta ifAbsent: [ nil ].
	^ meta
		ifNil: [ 
			false
		] ifNotNil: [ :m |
			| delete |
			delete := meta at: #delete ifAbsent: [ nil ].
			delete isNotNil and: [ delete ]
		]
