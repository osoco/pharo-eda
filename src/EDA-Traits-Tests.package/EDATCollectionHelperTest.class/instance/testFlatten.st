tests
testFlatten
	| sample a b c d e actual expected |
	a := 'a'.
	b := {('1' -> 'a').
	('2' -> 'A')} asDictionary.
	c := OrderedCollection with: b.
	d := OrderedCollection with: 'd' with: c.
	e := {('x' -> '3').
	('y' -> '4')} asDictionary.
	sample := OrderedCollection
		with: a
		with: b
		with: c
		with: d
		with: e.
	expected := OrderedCollection
		with: 'a'
		with: b
		with: b
		with: 'd'
		with: b
		with: e.
	actual := self flatten: sample.
	self assert: actual equals: expected