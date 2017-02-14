error handling
handleError: t1
	| t2 |
	t2 := self context at: #producedEvents ifAbsent: OrderedCollection new.
	t1 debug.
	^ t2