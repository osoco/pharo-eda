testing
isActionHandled
	^ (Pragma allNamed: #projectionForEvents: in: method methodClass) anySatisfy: [ :p | p method = method ]