initialization
buildBodySectionForEvent: anEvent
	^ Dictionary newFrom:
		(anEvent class allInstVarNames \ {#aggregateRootClass . #timestamp . #commandId . #version}
			collect: [ :var | var -> (anEvent instVarNamed: var) ])