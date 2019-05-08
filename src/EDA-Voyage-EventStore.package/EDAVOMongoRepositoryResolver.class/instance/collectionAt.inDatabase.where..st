private persistence
collectionAt: aClass inDatabase: db where: aDictionary
	^ aDictionary at: 'aggregateRootClass' ifAbsent: [ super collectionAt: aClass inDatabase: db ]