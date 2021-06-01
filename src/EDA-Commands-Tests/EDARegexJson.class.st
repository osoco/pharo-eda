Class {
	#name : #EDARegexJson,
	#superclass : #Object,
	#category : 'EDA-Commands-Tests'
}

{ #category : #building }
EDARegexJson class >> fromString: aString andTestCase: aTestCase [
	"Builds a RegexJson from given string"

	^ EDARegexJsonDictionary newFrom: (NeoJSONReader fromString: aString) andTestCase: aTestCase
]
