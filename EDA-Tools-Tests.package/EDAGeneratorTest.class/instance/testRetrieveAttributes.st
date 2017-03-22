test
testRetrieveAttributes
	| generator |
	generator := EDAGenerator new.
	generator json: { (#body -> { (#a -> 1) . (#b -> 2) . (#c -> 3) } asDictionary ) } asDictionary.
	self assert: generator retrieveCommandAttributes equals: #(#a #b #c) asSortedCollection