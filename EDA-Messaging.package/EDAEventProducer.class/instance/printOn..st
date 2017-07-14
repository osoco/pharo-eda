helpers
printOn: t1
	| t2 |
	t2 := ''.
	self class allInstVarNames
		do: [ :t4 | 
			t2 isEmpty
				ifTrue: [ t2 := '{ ' ]
				ifFalse: [ t2 := t2 , ', ' ].
			t2 := t2 , '"' , t4 , '": "' , (self instVarNamed: t4) asString , '"' ].
	t2 := t2 , ' }'.
	t1 nextPutAll: t2.
	^ self