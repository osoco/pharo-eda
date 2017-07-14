instance creation
newFrom: aString andTestCase: aTestCase
	| result |
	result := self new.
	result dict: (Dictionary newFrom: aString).
	result testCase: aTestCase.
	^ result