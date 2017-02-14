accessing
produceEvent: anEvent
	| message routingKey |
	message := self serializer serialize: anEvent.
	routingKey := EDAEventProducer routingKey: anEvent.
	Transcript print: 'Publishing event: ', message; cr; flush.
	routingKey
		ifNotNil: [ self publisher publishMessage: message withRoutingKey: routingKey ]
		ifNil: [ self publisher publishMessage: message ].
	Transcript print: 'Event published.'; cr; flush