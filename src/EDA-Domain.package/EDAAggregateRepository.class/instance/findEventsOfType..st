api
findEventsOfType: aType
	^ self findAllEventsMatching: { '#instanceOf' -> aType greaseString } asDictionary
