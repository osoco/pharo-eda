Class {
	#name : #EDATJsonMatchingHelperTest,
	#superclass : #TestCase,
	#traits : 'EDATJsonMatchingHelper',
	#classTraits : 'EDATJsonMatchingHelper classTrait',
	#category : 'EDA-Commands-Tests-Tests'
}

{ #category : #testing }
EDATJsonMatchingHelperTest >> test_deep_nested_jsons_match [
	"Tests whether two JSON with nested values are considered the same"

	| json1 jsonRegex |
	json1 := '{ "a": { "b": { "c": "whatever" }, "d": [ 1, 2, 3 ], "e": { "f": { "g": "end" } } }}'.
	jsonRegex := '{ "a": { "b": { "c": "(.*)" }, "d": "(.*)", "e": { "f": { "g": "(.*)" } } }}'.
	self assert: (self assertJson: json1 matchesRegex: jsonRegex).
	jsonRegex := '{ "a": { "b": { "c": "(.*)" }, "e": { "f": { "g": "(.*)" } }, "d": [ 1, 2, 3 ] }}'.
	self assert: (self assertJson: json1 matchesRegex: jsonRegex)
]

{ #category : #testing }
EDATJsonMatchingHelperTest >> test_empty_jsons_match [
	"Tests whether two empty JSON are considered the same"

	| json1 json2 |
	json1 := ''.
	json2 := ''.
	self assert: (self assertJson: json1 matchesRegex: json2).
]

{ #category : #testing }
EDATJsonMatchingHelperTest >> test_jsons_with_anything_keyword_match [
	"Tests whether two JSONs, one with a date, and another with '<ANYTHING>', are considered the same"

	| json jsonRegex date |
	date := DateAndTime now.
	json := '{ "a": 1, "b": 3,    "c": "' , date asString , '" }'.
	jsonRegex := '{ "a": 1,"b":3,  "c":       "<ANYTHING>"}'.
	self assert: (self assertJson: json matchesRegex: jsonRegex).
	json := '{ "d": "bla",   "e ": "{}" }'.
	jsonRegex := '{ "d": "<ANYTHING>", "e ": ".*"    }'.
	self assert: (self assertJson: json matchesRegex: jsonRegex).
	jsonRegex := '{ "d": "(.*)", "e ": ".*"    }'.
	self assert: (self assertJson: json matchesRegex: jsonRegex)
]

{ #category : #testing }
EDATJsonMatchingHelperTest >> test_medium_jsons_do_not_match [
	"Tests whether two medium-sized JSON are considered different"

	| json1 json2 |
	json1 := '{ "a": 1, "b": 3,    "c": "my-value" }'.
	json2 := '{ "a": 1,"b":3,  "c":       "my-other-value"}'.
	self assert: (self assertJson: json1 matchesRegex: json2) not
]

{ #category : #testing }
EDATJsonMatchingHelperTest >> test_medium_jsons_match [
	"Tests whether two medium-sized JSON are considered the same"

	| json1 json2 |
	json1 := '{ "a": 1, "b": 3,    "c": "my-value" }'.
	json2 := '{ "a": 1,"b":3,  "c":       "my-value"}'.
	self assert: (self assertJson: json1 matchesRegex: json2)
]

{ #category : #testing }
EDATJsonMatchingHelperTest >> test_nested_jsons_match [
	"Tests whether two JSON with nested values are considered the same"

	| json1 json2 |
	json1 := '{ "a": 1, "b": 3,    "c": { "d": "other" }}'.
	json2 := '{ "a": 1,"b":3,  "c":    { "d": "(.*)" } }'.
	self assert: (self assertJson: json1 matchesRegex: json2)
]

{ #category : #testing }
EDATJsonMatchingHelperTest >> test_simple_jsons_do_not_match [
	"Tests whether two simple JSON are considered different"

	| json1 json2 |
	json1 := '{ "a": 1 }'.
	json2 := '{ "a": 2 }'.
	self assert: (self assertJson: json1 matchesRegex: json2) not
]

{ #category : #testing }
EDATJsonMatchingHelperTest >> test_simple_jsons_match [
	"Tests whether two simple JSON are considered the same"

	| json1 json2 |
	json1 := '{ "a"    :            1 
	}'.
	json2 := '{"a":1}'.
	self assert: (self assertJson: json1 matchesRegex: json2)
]
