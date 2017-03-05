testing
test_medium_jsons_do_not_match
	"Tests whether two medium-sized JSON are considered different"

	| json1 json2 |
	json1 := '{ "a": 1, "b": 3,    "c": "my-value" }'.
	json2 := '{ "a": 1,"b":3,  "c":       "my-other-value"}'.
	self assert: (self json: json1 matchesRegex: json2) not