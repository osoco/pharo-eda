event retrieval
sourceEvents: anEventStore ofTenant: aTenant
	| eventTypes aux result |
	eventTypes := ((Pragma
		allNamed: 'projectionForEvents:'
		in: self class) collect: [ :p | p arguments first ]) flattened.
	aux := OrderedCollection new.
	eventTypes
		do: [ :t |
			aux
				addAll: (anEventStore findEventsOfTenant: aTenant ofType: (self class environment at: t)) ].
	result := self
		removeDuplicatesIn: aux
		matching: self removeDuplicatesBlock.
	result := aux.
	^ result