Class {
	#name : #RegexJson,
	#superclass : #Object,
	#category : 'EDA-Commands-Tests'
}

{ #category : #building }
RegexJson class >> fromString: aString andTestCase: aTestCase [
	"Builds a RegexJson from given string"

	^ RegexJsonDictionary newFrom: (NeoJSONReader fromString: aString) andTestCase: aTestCase
]
