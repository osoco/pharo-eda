comparing
deepEqualsDictionary: aDict with: anotherDict
	^ (aDict size = anotherDict size)
		and: [
			(aDict keys reject: [ :k |
				self deepEquals: (aDict at: k) with: (anotherDict at: k ifAbsent: [ nil ])
			]) isEmpty
		]