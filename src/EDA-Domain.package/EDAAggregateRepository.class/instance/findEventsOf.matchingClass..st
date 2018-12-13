api
findEventsOf: aCollection matchingClass: aClass
	| result |
	result :=
		aCollection
			ifNil: [ OrderedCollection new ]
			ifNotNil: [ :col |
				 col
					ifEmpty: [ col ]
					ifNotEmpty: [ :c |
						c select: [ :e | (e class = aClass) or: [ e class isKindOf: aClass ] ]
					]
			].
	^ result