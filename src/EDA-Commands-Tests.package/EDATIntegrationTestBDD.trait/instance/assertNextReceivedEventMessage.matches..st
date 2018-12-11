asserting
assertNextReceivedEventMessage: stompListener matches: eventMessageRegex
	| frame ack nack |
	self logInfoMessage: 'Waiting for incoming messages...'.
	[ frame := stompListener client readMessage.
	ack := frame ackFrame.
	nack := frame nackFrame.
	stompListener client write: ack.
	self logDebugMessage: 'Received event: ' , frame body greaseString.
	self assertGeneratedEvent: frame matchesRegex: eventMessageRegex.
	^ frame ]
		on: Error
		do: [ :ex |
			self logErrorMessage: 'Error consuming message: ' , ex description greaseString.
			self fail: 'Error consuming message: ', ex description greaseString.
			"nack ifNotNil: [ :arg |
			arg headers at: 'requeue' put: 'False'.
			stompListener client writeWithReceipt: arg.
			self unsubscribeToEvents
		]."
			^ frame ]