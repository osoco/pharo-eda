bdd
assertNextReceivedEventMessage: stompListener matches: eventMessageRegex
	| frame ack |
	Transcript
		print: 'Waiting for incoming messages...';
		cr.
	frame := stompListener client readMessage.
	ack := frame ackFrame.
 	stompListener client write: ack.
	Transcript
		print: 'Received event: ' , frame body;
		cr.
	self assertGeneratedEvent: frame matchesRegex: eventMessageRegex.
	^ frame