helper
retrieveMaxVersion
	| parent |
	parent := self commandFile parent parent.
	parent entries isEmpty
		ifTrue: [ ^ -1 ]
		ifFalse: [ 
			^ ((parent entries
				select: [ :entry | entry isDirectory and: [ entry basename beginsWith: 'v' ] ]
				thenCollect: [ :entry | (EDAGenerator new removePrefix: 'v' from: entry basename) asInteger ])
				asOrderedCollection sort: [ :first :second | first < second ]) last ]