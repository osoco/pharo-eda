testing
test_simple_jsons_match
	"Tests whether two simple JSON are considered the same"

	| json1 json2 |
	json1 := '{ "a"    :            1 
	}'.
	json2 := '{"a":1}'.
	self assert: (self json: json1 matchesRegex: json2)