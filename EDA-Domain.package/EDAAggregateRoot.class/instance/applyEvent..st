event handling
applyEvent: anEvent
	| eventClassName applyEventSelector applyEventSelectorSymbol |
	eventClassName := anEvent class name.
	applyEventSelector := self retrieveApplyEventMethod: anEvent.
	applyEventSelector
		ifNotNil: [ applyEventSelectorSymbol := applyEventSelector asSymbol.
			Transcript
				print: 'Applying event ' , eventClassName , ' via ' , applyEventSelectorSymbol;
				cr;
				flush.
			self perform: applyEventSelectorSymbol with: anEvent ]
		ifNil: [ Transcript print: 'Not retrieved apply event method for ' , eventClassName; cr; flush. ]