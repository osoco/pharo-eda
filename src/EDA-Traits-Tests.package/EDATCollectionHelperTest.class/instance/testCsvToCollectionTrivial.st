tests
testCsvToCollectionTrivial
	| sample actual expected |
	sample := 'a,b,c'.
	expected := OrderedCollection with: 'a' with: 'b' with: 'c'.
	actual := self csvToCollection: sample.
	self assert: actual equals: expected