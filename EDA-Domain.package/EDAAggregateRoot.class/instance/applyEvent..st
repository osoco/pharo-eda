event handling
applyEvent: anEvent
	| eventClassName applyEventSelector applyEventSelectorSymbol |
	eventClassName := anEvent class name.
	applyEventSelector := self
		retrieveApplyEventMethod: anEvent
		withLogging: false.
	applyEventSelector
		ifNotNil: [ :arg | 
			| text max last suffix |
			max := 50.
			suffix := ''.
			text := anEvent greaseString.
			text size > max
				ifTrue: [ last := max.
					suffix := '...' ]
				ifFalse: [ last := text size ].
			applyEventSelectorSymbol := applyEventSelector asSymbol.
			Transcript
				print: self class greaseString;
				print: '(';
				print: self id;
				print: ')>>';
				print: applyEventSelectorSymbol;
				print: ' ''';
				print: (text copyFrom: 1 to: last);
				print: suffix;
				cr.
			self perform: applyEventSelectorSymbol with: anEvent ]
		ifNil: [ Transcript
				print: 'ERROR: No way to apply event : ' , anEvent greaseString;
				cr;
				flush.
			self retrieveApplyEventMethod: anEvent withLogging: true ]