scanning
allCommandHandlerMethods
	| handlerPragmas handlerMethodAssocs |
	handlerPragmas := Set new.
	self fromClass allSubclasses
		do:
			[ :subclass | handlerPragmas addAll: (Pragma allNamed: self pragma in: subclass) ].
	handlerMethodAssocs := (handlerPragmas
		select: [ :handlerPragma | 
			(self class environment
				at: (handlerPragma argumentAt: 1)
				ifAbsent: [ nil ]) isNotNil ])
		collect: [ :handlerPragma | 
			(self class environment at: (handlerPragma argumentAt: 1))
				-> handlerPragma method ].
	^ handlerMethodAssocs ifEmpty: [ nil ]