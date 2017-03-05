building
fromString: aString
	"Builds a RegexJson from given string"

	^ RegexJson newFrom: (NeoJSONReader fromString: aString)