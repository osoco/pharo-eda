testing
test_nested_jsons_match
	"Tests whether two JSON with nested values are considered the same"

	| json1 json2 |
	json1 := '{ "a": 1, "b": 3,    "c": { "d": "other" }}'.
	json2 := '{ "a": 1,"b":3,  "c":    { "d": "(.*)" } }'.
	self assert: (self assertJson: json1 matchesRegex: json2)