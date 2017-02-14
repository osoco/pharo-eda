bdd
eventMessagesMatch: expectedEventMessages withRoutingKeys: expectedRoutingKeys
	| anyEventGenerated |
	[
	anyEventGenerated := false.
	expectedEventMessages
		doWithIndex: [ :eventMessageRegex :index |
			| frame |
			frame := self nextReceivedEventMessage: self eventListener matches: eventMessageRegex.
			anyEventGenerated := true.
			expectedRoutingKeys size >= index
				ifTrue: [ self assert: (self routingKeyFromDestination: frame destination) equals: (expectedRoutingKeys at: index) ] ] ]
		on: ConnectionTimedOut
		do: [ :ex |
			anyEventGenerated
				ifTrue: [ self fail: 'At least one of the generated events do not match the expected regular expression' ]
				ifFalse: [ self fail: 'No events generated' ] ]