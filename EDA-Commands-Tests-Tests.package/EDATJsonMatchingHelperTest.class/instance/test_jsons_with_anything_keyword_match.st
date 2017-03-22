testing
test_jsons_with_anything_keyword_match
	"Tests whether two JSONs, one with a date, and another with '<ANYTHING>', are considered the same"

	| json jsonRegex date |
	date := DateAndTime now.
	json := '{ "a": 1, "b": 3,    "c": "' , date asString , '" }'.
	jsonRegex := '{ "a": 1,"b":3,  "c":       "<ANYTHING>"}'.
	self assert: (self json: json matchesRegex: jsonRegex).
	json := '{ "d": "bla",   "e ": "{}" }'.
	jsonRegex := '{ "d": "<ANYTHING>", "e ": ".*"    }'.
	self assert: (self json: json matchesRegex: jsonRegex).
	jsonRegex := '{ "d": "(.*)", "e ": ".*"    }'.
	self assert: (self json: json matchesRegex: jsonRegex)