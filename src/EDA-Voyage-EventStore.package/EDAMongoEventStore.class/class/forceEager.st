accessing
forceEager
	forceEager ifNil: [ self forceEager: false ].
	^ forceEager