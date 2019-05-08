private persistence
collectionAt: aClass inDatabase: db where: aDictionary
	| collectionName |
	collectionName := aDictionary at: 'aggregateRootClass' ifAbsent: [ nil ].
	^ collectionName ifNotNil: [ MongoCollection database: db name: collectionName ] ifNil: [ super collectionAt: aClass inDatabase: db ]