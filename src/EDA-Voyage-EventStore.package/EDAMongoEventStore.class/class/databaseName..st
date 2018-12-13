accessing
databaseName: anObject
	"databaseName cannot be changed on the fly, so refreshVoyageSettings won't refresh anything.
	The EDAApplication needs to be reloaded"

	databaseName := anObject