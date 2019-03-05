event retrieval
sourceEvents: anEventStore
	| eventTypes aux result |
	eventTypes := ((Pragma allNamed: 'projectionForEvents:' in: self class) collect: [ :p | p arguments first ]) flattened.
	aux := OrderedCollection new.
	eventTypes do: [ :t | aux addAll: (anEventStore findEventsOfType: (self class environment at: t)) ].
	result := self removeDuplicatesIn: aux matching: self removeDuplicatesBlock.
	result := aux.
	^ result