projecting
delegateEventProjectionOf: anEvent in: aProjection to: aProjectionMethod
	| result |
	result := self perform: aProjectionMethod selector with: anEvent with: aProjection.
	^ result