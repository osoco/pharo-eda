event handling
applyEvent: anEvent
	| eventClassName applyEventSelector applyEventSelectorSymbol delete |
	delete := anEvent delete.
	delete
		ifNil: [ self logWarningMessage: anEvent class greaseString , ' implements an invalid #initialize method. Make sure it calls parent''s initialize.'.
			delete := false ].
	delete
		ifTrue: [ ^ self ].
	eventClassName := anEvent class greaseString.
	applyEventSelector := self retrieveApplyEventMethod: anEvent withLogging: false.
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
		ifNil: [ self logErrorMessage: 'No way to apply event : ' , anEvent greaseString, '.'.
			self retrieveApplyEventMethod: anEvent withLogging: true ]