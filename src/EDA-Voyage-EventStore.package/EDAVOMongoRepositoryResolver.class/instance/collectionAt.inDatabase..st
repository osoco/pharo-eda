private persistence
collectionAt: aClass inDatabase: db
	| collectionName |
	collectionName := aClass aggregateRootClass greaseString.
	^ MongoCollection database: db name: collectionName