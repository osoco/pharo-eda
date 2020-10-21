event handling
applyEvent: anEvent
	| eventClassName applyEventSelector applyEventSelectorSymbol delete |
	delete := anEvent delete.
	delete
		ifNil: [ self
				logWarningMessage:
					((WriteStream on: String new)
						nextPutAll: anEvent class greaseString;
						nextPutAll:
							' implements an invalid #initialize method. Make sure it calls parent''s initialize.';
						close;
						contents).
			delete := false ].
	delete
		ifTrue: [ self applyAggregateDeletedEvent: anEvent ]
		ifFalse: [ eventClassName := anEvent class greaseString.
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
					self
						logTraceMessage:
							((WriteStream on: String new)
								nextPutAll: self class greaseString;
								nextPut: $(;
								nextPutAll: self id greaseString;
								nextPutAll: ')>>';
								nextPutAll: applyEventSelectorSymbol greaseString;
								nextPutAll: ' ''';
								nextPutAll: (text copyFrom: 1 to: last) greaseString;
								nextPutAll: suffix greaseString;
								close;
								contents).
					self perform: applyEventSelectorSymbol with: anEvent.
					self id: anEvent id.
					self brandNew: false ]
				ifNil: [ anEvent class greaseString = self class greaseString
						ifTrue: [ self
								logErrorMessage:
									((WriteStream on: String new)
										nextPutAll: 'Aggregate root class mismatch for ';
										nextPutAll: anEvent class greaseString;
										nextPutAll: ' event : ';
										nextPutAll: anEvent greaseString;
										nextPutAll: '. It''s ';
										nextPutAll: self class greaseString;
										nextPutAll: ' but should be ';
										nextPutAll: anEvent aggregateRootClass greaseString;
										close;
										contents) ].
					self retrieveApplyEventMethod: anEvent withLogging: true ] ]