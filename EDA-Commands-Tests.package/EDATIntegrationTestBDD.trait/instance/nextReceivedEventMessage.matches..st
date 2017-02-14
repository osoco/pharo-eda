bdd
nextReceivedEventMessage: stompListener matches: eventMessageRegex
	| frame |
	Transcript print: 'Waiting for incoming messages...'; cr; flush.
	frame := stompListener readMessage.
	Transcript print: 'Received event: ', frame message; cr; flush.
	self generatedEvent: frame matchesRegex: eventMessageRegex.
	^ frame