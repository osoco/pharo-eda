projection retrieval
projectEvents: aCollectionOfEvents to: aProjectionClass
	aCollectionOfEvents do: [ :anEvent | aProjectionClass projectEvent: anEvent ]