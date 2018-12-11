building
fromString: aString andTestCase: aTestCase
	"Builds a RegexJson from given string"

	^ RegexJsonDictionary newFrom: (NeoJSONReader fromString: aString) andTestCase: aTestCase