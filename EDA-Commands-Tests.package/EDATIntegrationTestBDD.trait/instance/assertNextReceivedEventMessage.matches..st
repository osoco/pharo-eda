asserting
assertNextReceivedEventMessage: stompListener matches: eventMessageRegex
	| frame ack nack |
	Transcript
		print: 'Waiting for incoming messages...';
		cr.
	[
		frame := stompListener client readMessage.
		ack := frame ackFrame.
		nack := frame nackFrame.
	 	stompListener client write: ack.
		Transcript
			print: 'Received event: ' , frame body;
			cr.
		self assertGeneratedEvent: frame matchesRegex: eventMessageRegex.
		^ frame
	]
	on: Error
	do: [ :ex |
		Transcript
			print: '<< Error consuming message: ';
			print: ex description;
			cr.
		"nack ifNotNil: [ :arg |
			arg headers at: 'requeue' put: 'False'.
			stompListener client writeWithReceipt: arg.
			self unsubscribeToEvents
		]."
		^ frame
	]