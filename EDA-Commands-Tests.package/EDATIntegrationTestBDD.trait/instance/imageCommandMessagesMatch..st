bdd
imageCommandMessagesMatch: expectedCommandMessages
	| anyCommandGenerated |
	[ anyCommandGenerated := true.
	expectedCommandMessages
		keysAndValuesDo: [ :index :eventMessageRegex |
			| frame |
			frame := self imageListener client readMessage.
			anyCommandGenerated := true.
			self generatedEvent: frame matchesRegex: eventMessageRegex ] ]
		on: ConnectionTimedOut
		do: [ :ex | 
			anyCommandGenerated
				ifTrue: [ self
						fail:
							'At least one of the generated commands do not match the expected regular expression' ]
				ifFalse: [ self fail: 'No commands generated' ] ]
