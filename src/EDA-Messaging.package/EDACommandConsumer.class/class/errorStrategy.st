instance creation
errorStrategy
	| result |
	result := EDACommandConsumingErrorBehavior strategy.
	result ifNil: [ result := EDADefaultErrorBehavior strategy ].
	^ result