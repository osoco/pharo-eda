scanning
allCommandHandlerMethods
	| handlerPragmas handlerMethodAssocs |
	handlerPragmas := Set new.
	self fromClass allSubclasses do: [ :subclass | handlerPragmas addAll: (Pragma allNamed: self pragma in: subclass) ].
	handlerMethodAssocs := handlerPragmas
		collect: [ :handlerPragma | (handlerPragma argumentAt: 1) asClass -> handlerPragma method ].
	^ handlerMethodAssocs ifEmpty: [ nil ]