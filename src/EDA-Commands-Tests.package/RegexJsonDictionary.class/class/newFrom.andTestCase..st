instance creation
newFrom: aDictionary andTestCase: aTestCase
	| result |
	result := self withAll: aDictionary.
	result testCase: aTestCase.
	^ result