tests
testRemoveDuplicatesInMatching
	| fixture trimmed |
	fixture := {{('id' -> 'foo').
	('field' -> 'something')} asDictionary.
	{('id' -> 'foo').
	('extra' -> 'bar')} asDictionary.
	{('id' -> 'item1').
	('value' -> 'something')} asDictionary} asOrderedCollection.
	trimmed := self removeDuplicatesIn: fixture matching: [ :first :second | (first at: 'id') = (second at: 'id') ].
	self assert: trimmed isNotNil.
	self assert: trimmed size = 2