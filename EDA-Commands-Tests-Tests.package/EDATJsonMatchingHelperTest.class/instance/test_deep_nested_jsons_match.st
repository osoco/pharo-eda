testing
test_deep_nested_jsons_match
	"Tests whether two JSON with nested values are considered the same"

	| json1 jsonRegex |
	json1 := '{ "a": { "b": { "c": "whatever" }, "d": [ 1, 2, 3 ], "e": { "f": { "g": "end" } } }}'.
	jsonRegex := '{ "a": { "b": { "c": "(.*)" }, "d": "(.*)", "e": { "f": { "g": "(.*)" } } }}'.
	self assert: (self json: json1 matchesRegex: jsonRegex)