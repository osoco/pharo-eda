api
projectFilteredEvents: anEventCollection
	self projectors do: [ :projector | projector projectFilteredEvents: anEventCollection ]