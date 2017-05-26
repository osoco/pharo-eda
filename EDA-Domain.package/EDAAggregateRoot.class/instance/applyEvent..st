event handling
applyEvent: anEvent
	| eventClassName applyEventSelector applyEventSelectorSymbol |
	eventClassName := anEvent class name.
	applyEventSelector := self retrieveApplyEventMethod: anEvent withLogging: false.
	applyEventSelector
		ifNotNil: [ applyEventSelectorSymbol := applyEventSelector asSymbol.
			Transcript
				print: 'Applying event ' , eventClassName , ' via ' , applyEventSelectorSymbol;
				cr;
				flush.
			self perform: applyEventSelectorSymbol with: anEvent ]
		ifNil: [ Transcript
				print: 'ERROR: No way to apply event : ' , anEvent greaseString;
				cr;
				flush.
			self retrieveApplyEventMethod: anEvent withLogging: true ]