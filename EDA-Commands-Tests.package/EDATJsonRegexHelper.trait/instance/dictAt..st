as yet unclassified
dictAt: key
	"Answer the value associated with the key."

	^ self at: key ifAbsent: [ {('(.*)' -> '(.*)')} asDictionary ]