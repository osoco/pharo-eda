helpers
assertJson: jsonText matchesRegex: regex
	"Checks whether given JSON match the regex-enhanced JSON text"

	^ jsonText isNil
		ifTrue: [ ^ regex isNil ]
		ifFalse: [ regex isEmpty
				ifTrue: [ ^ regex isEmpty ]
				ifFalse: [ | json regexJson |
					json := NeoJSONReader fromString: jsonText.
					regexJson := RegexJson fromString: regex andTestCase: self.
					^ regexJson assertMatches: json ] ]