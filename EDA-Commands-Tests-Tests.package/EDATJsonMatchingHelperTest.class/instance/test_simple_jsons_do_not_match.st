testing
test_simple_jsons_do_not_match
	"Tests whether two simple JSON are considered different"

	| json1 json2 |
	json1 := '{ "a": 1 }'.
	json2 := '{ "a": 2 }'.
	self assert: (self assertJson: json1 matchesRegex: json2) not