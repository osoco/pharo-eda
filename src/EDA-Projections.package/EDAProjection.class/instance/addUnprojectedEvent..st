accessing
addUnprojectedEvent: anEvent
	"I'm not sure if this can lead to duplicate saves in Mongo. It's disabled until I figure it out.
	| collection |
	collection := self unprojectedEvents copy.
	collection add: anEvent.
	self unprojectedEvents: collection"