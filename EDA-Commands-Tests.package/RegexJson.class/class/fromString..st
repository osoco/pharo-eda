building
fromString: aString
	"Builds a RegexJson from given string"

	^ RegexJsonDictionary newFrom: (NeoJSONReader fromString: aString)