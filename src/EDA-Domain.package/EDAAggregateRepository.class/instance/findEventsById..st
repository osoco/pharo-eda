api
findEventsById: anId
	^ self findAllEventsMatching: { 'id' -> anId } asDictionary