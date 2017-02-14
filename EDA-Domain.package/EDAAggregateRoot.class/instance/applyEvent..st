event handling
applyEvent: anEvent
	| eventClassName applyEventSelectorSymbol |
	eventClassName := anEvent class name.
	applyEventSelectorSymbol := ('apply' , (anEvent class asString allButFirst: (EDAMessageSerializer eventClassPrefix: anEvent class) size) , ':') asSymbol.
	Transcript print: 'Applying event ', eventClassName, ' via ', applyEventSelectorSymbol; cr; flush.
	self perform: applyEventSelectorSymbol with: anEvent