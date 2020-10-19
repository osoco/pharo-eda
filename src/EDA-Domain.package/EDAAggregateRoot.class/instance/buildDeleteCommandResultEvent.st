helper
buildDeleteCommandResultEvent
	| result eventClass candidates |
	eventClass := nil.
	candidates := EDADeleteCommandResultEvent allSubclasses
		select: [ :cls | 
			cls aggregateRootClass = self class
				and: [ (cls greaseString indexOfSubCollection: 'Test' startingAt: 0) = 0 ] ].
	candidates
		ifEmpty: [ self
				logErrorMessage:
					(String
						streamContents: [ :s |
							s
								nextPutAll: 'Cannot find delete event for aggregate ';
								nextPutAll: self class greaseString ])
				andThrow: MissingDeleteEventClassForAggregate ]
		ifNotEmpty: [ :c | 
			c size > 1
				ifTrue: [ self
						logErrorMessage:
							(String
								streamContents: [ :s |
									s
										nextPutAll: 'Too many delete events for aggregate: ';
										nextPutAll: self class greaseString ]) andThrow: TooManyDeleteEventClassesForAggregate ].
			eventClass := c first ].
	result := eventClass ifNotNil: [ :cls | cls new ].
	^ result