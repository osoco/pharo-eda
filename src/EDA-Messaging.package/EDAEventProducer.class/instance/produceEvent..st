accessing
produceEvent: anEvent
	| message routingKey |
	message := self serializer serialize: anEvent.
	routingKey := self class routingKey: anEvent.
	routingKey
		ifNotNil: [ :arg | self publisher publishMessage: message withRoutingKey: routingKey ]
		ifNil: [ self publisher publishMessage: message ].
	(anEvent class inheritsFrom: Announcement)
		ifTrue: [ self announcer announce: anEvent ]