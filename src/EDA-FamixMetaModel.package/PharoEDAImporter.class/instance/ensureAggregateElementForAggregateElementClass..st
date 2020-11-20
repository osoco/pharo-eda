public-entity-creation
ensureAggregateElementForAggregateElementClass: anAggregateElementClassModel
	| aggregateElement |
	^ aggregateElements
		at: anAggregateElementClassModel
		ifAbsent: [ aggregateElement := self
				createAggregateElement: anAggregateElementClassModel.
			self addEntity: aggregateElement.
			self
				ensureAggregateElementUsingForAggregateElement: aggregateElement.
			aggregateElement ]