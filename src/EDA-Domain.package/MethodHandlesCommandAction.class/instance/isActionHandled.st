testing
isActionHandled
	^ (Pragma allNamed: #useAsCommandHandlerFor: in: method methodClass) anySatisfy: [ :p | p method = method ]