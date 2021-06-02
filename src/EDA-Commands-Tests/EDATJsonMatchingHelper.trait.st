Trait {
	#name : #EDATJsonMatchingHelper,
	#category : 'EDA-Commands-Tests'
}

{ #category : #helper }
EDATJsonMatchingHelper >> assertJson: jsonText matchesRegex: regex [
	"Checks whether given JSON match the regex-enhanced JSON text"

	^ jsonText isNil
		ifTrue: [ ^ regex isNil ]
		ifFalse: [ regex isEmpty
				ifTrue: [ ^ regex isEmpty ]
				ifFalse: [ | json regexJson |
					json := NeoJSONReader fromString: jsonText.
					regexJson := EDARegexJson fromString: regex andTestCase: self.
					^ regexJson assertMatches: json ] ]
]
