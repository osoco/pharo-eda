testing
test_medium_jsons_match
	"Tests whether two medium-sized JSON are considered the same"

	| json1 json2 |
	json1 := '{ "a": 1, "b": 3,    "c": "my-value" }'.
	json2 := '{ "a": 1,"b":3,  "c":       "my-value"}'.
	self assert: (self assertJson: json1 matchesRegex: json2)