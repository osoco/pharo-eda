Trait {
	#name : #EDATJsonMatchingHelper,
	#category : #'EDA-Commands-Tests'
}

{ #category : #helper }
EDATJsonMatchingHelper >> assertJson: jsonText matchesRegex: regex [
	"Checks whether given JSON match the regex-enhanced JSON text"
	| result |
	result := jsonText
		ifNil: [ regex isNil ]
		ifNotNil: [ regex isEmpty
				ifTrue: [ regex isEmpty ]
				ifFalse: [ | json regexJson |
					json := NeoJSONReader fromString: jsonText.
					regexJson := RegexJson fromString: regex andTestCase: self.
					regexJson assertMatches: json ] ].
	self assert: result
]
