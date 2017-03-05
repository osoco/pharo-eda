testing
test_empty_jsons_match
	"Tests whether two empty JSON are considered the same"

	| json1 json2 |
	json1 := ''.
	json2 := ''.
	self assert: (self json: json1 matchesRegex: json2).