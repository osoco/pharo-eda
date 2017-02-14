as yet unclassified
isEvent: event inCollection: events
	"Checks if the event is contained in given list"
	^ events anySatisfy: [ :e | e = event ]
	