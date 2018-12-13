event filtering
filterEventsToProject: anEventCollection accordingToTimestamp: aTimestamp
	^ (anEventCollection select: [ :each | each timestamp > aTimestamp ]) asSortedCollection: [ :i :j | i timestamp < j timestamp ]