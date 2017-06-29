bdd
assertNextReceivedEventMessage: stompListener matches: eventMessageRegex
	| frame |
	Transcript
		print: 'Waiting for incoming messages...';
		cr;
		flush.
	frame := stompListener client readMessage.
	Transcript
		print: 'Received event: ' , frame body;
		cr;
		flush.
	self assertGeneratedEvent: frame matchesRegex: eventMessageRegex.
	^ frame