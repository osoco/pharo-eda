Class {
	#name : #EDATJsonMatchingHelperTest,
	#superclass : #TestCase,
	#traits : 'EDATJsonMatchingHelper + EDATDomainBDD',
	#classTraits : 'EDATJsonMatchingHelper classTrait + EDATDomainBDD classTrait',
	#category : #'EDA-Commands-Tests-Tests'
}

{ #category : #testing }
EDATJsonMatchingHelperTest >> test_deep_nested_jsons_match [
	"Tests whether two JSON with nested values are considered the same"

	| json1 jsonRegex |
	json1 := '{ "a": { "b": { "c": "whatever" }, "d": [ 1, 2, 3 ], "e": { "f": { "g": "end" } } }}'.
	jsonRegex := '{ "a": { "b": { "c": "(.*)" }, "d": "(.*)", "e": { "f": { "g": "(.*)" } } }}'.
	self assertJson: json1 matchesRegex: jsonRegex.
	jsonRegex := '{ "a": { "b": { "c": "(.*)" }, "e": { "f": { "g": "(.*)" } }, "d": [ 1, 2, 3 ] }}'.
	self assertJson: json1 matchesRegex: jsonRegex
]

{ #category : #testing }
EDATJsonMatchingHelperTest >> test_empty_jsons_match [
	"Tests whether two empty JSON are considered the same"

	| json1 json2 |
	json1 := ''.
	json2 := ''.
	self assertJson: json1 matchesRegex: json2.
]

{ #category : #testing }
EDATJsonMatchingHelperTest >> test_event_jsons_do_not_match [
	"Tests whether two simple JSON are considered different"

	| json1 json2 |
	json1 := '
    {
        "body" : {
            "scopeKey" : [
                "group-1"
            ],
            "aggregateRootVersion" : 1,
            "delete" : false,
            "id" : "07c51401-9694-0d00-ac36-fde80f3899a1",
            "applicantKey" : "algo",
            "agent" : null,
            "tenant" : "tenant-1",
            "version" : 1,
            "dateCreated" : "2022-02-17T10:31:21+00:00",
            "scopeContext" : {
                "scope" : "group",
                "scopes" : {
                    "group" : {
                        "id" : "group-1",
                        "subgroup" : {
                            "id" : "subgroup-1"
                        }
                    }
                }
            }
        },
        "meta" : {
            "delete" : false,
            "version" : 2,
            "timestamp" : "2022-02-17T10:31:23+00:00",
            "id" : "13ce2a01-9694-0d00-ac37-c41d0f3899a1",
            "correlationId" : "c03785c0-3be9-4847-9242-2917ec77d60b",
            "type" : "APPLICANT_CREATED"
        }
    }
	'.
	json2 := '
    {
    "meta": {
        "id": "<ANYTHING>",
        "version": 2,
        "timestamp": "1970-01-01T00:00:00",
        "correlationId": "c03785c0-3be9-4847-9242-2917ec77d60b",
        "type": "APPLICANT_CREATED",
        "aggregate": "APPLICANT"
    },
    "body": {
        "tenant": "tenant-1",
        "scopeContext": {
        "scopes": {
            "group": {
            "id": "group-1",
            "subgroup": {
                "id": "subgroup-1"
            }
            }
        },
        "scope": "group"
        },
        "scopeKey": [ "group-1" ],
        "id": "applicant-1",
        "version": 1,
        "dateCreated": "1970-01-01T00:00:00",
        "applicantKey": "startup@applicants.com"
    }
    }

	'.
	[ self eventJsonMsg: json1 totallyMatchesWith: json2 forEventClass: ATSApplicantCreated ]
		on: EDAMismatchError
		do: [ :ex | self assert: json1 equals: json2 ]
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
