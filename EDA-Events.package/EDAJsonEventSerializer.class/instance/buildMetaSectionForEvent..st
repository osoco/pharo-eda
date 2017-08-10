initialization
buildMetaSectionForEvent: anEvent
	^ Dictionary
		newFrom:
			{('id' -> UUID new greaseString).
			('version' -> anEvent version).
			('timestamp' -> DateAndTime now asUTC rounded).
			('correlationId' -> anEvent commandId).
			('type' -> (self class asEventName: anEvent)).
			('delete' -> (anEvent delete))}
