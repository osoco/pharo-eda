*EDA-FamixMetaModel
isAggregateElement
	<MSEProperty: #isAggregateElement type: #Boolean>
	<multivalued>
	<derived>
	<MSEComment:
		'If the Class is an Aggregate Element in the context of an EDA Aggregate.'>
	^ self isAggregateRoot not
		and: [ self isAggregateRepository not
				and: [ self isException not
						and: [ self isCommand not and: [ self isEvent not ] ] ] ]