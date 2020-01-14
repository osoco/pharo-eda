event handling
applyEvent: anEvent
	| eventClassName applyEventSelector applyEventSelectorSymbol delete |
	delete := anEvent delete.
	delete
		ifNil: [ self logWarningMessage: anEvent class greaseString , ' implements an invalid #initialize method. Make sure it calls parent''s initialize.'.
			delete := false ].
	delete
		ifTrue: [ self applyAggregateDeletedEvent: anEvent ] ifFalse: [ 
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
			self logTraceMessage: self class greaseString , '(' , self id greaseString , ')>>' , applyEventSelectorSymbol greaseString , ' ''' , (text copyFrom: 1 to: last) greaseString , suffix greaseString.
			self perform: applyEventSelectorSymbol with: anEvent ]
		ifNil: [ (anEvent class greaseString = self class greaseString) ifTrue: [ self
				logErrorMessage: 'Aggregate root class mismatch for ' , anEvent class greaseString , ' event : ' , anEvent greaseString , '. It''s ' , self class greaseString , ' but should be ' , anEvent aggregateRootClass greaseString ].
			self retrieveApplyEventMethod: anEvent withLogging: true ] ]