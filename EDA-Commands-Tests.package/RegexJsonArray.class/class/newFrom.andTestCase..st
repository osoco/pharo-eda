instance creation
newFrom: anArray andTestCase: aTestCase
	| result |
	result := self new.
	result array: (Array newFrom: anArray).
	result testCase: aTestCase.
	^ result