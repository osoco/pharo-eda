accessing
port: anObject
	"port cannot be changed on the fly, so refreshVoyageSettings won't refresh anything.
	The EDAApplication needs to be reloaded"

	port := anObject